#/usr/bin/env python3

import os, sys

def read_int(input, byteCount, signed = False):
	return int.from_bytes(input.read(byteCount), byteorder = 'little', signed = signed)

NAMED_ADDRESSES = {
	0x203AA8A: "RESULT"
}

def name_address(address):
	if address in NAMED_ADDRESSES:
		return NAMED_ADDRESSES[address]

	return '[{:08X}]'.format(address)

NAMED_CHARACTERS = {}

def name_character(charId):
	if charId in NAMED_CHARACTERS:
		return NAMED_CHARACTERS[charId]

	return '<character:{}>'.format(charId)

class AiRawInstruction:

	def __init__(self, input):
		self.code  = read_int(input, 1)
		self.sarg0 = read_int(input, 1)
		self.sarg1 = read_int(input, 1)
		self.sarg2 = read_int(input, 1)

		self.larg0 = read_int(input, 4)
		self.larg1 = read_int(input, 4)
		self.larg2 = read_int(input, 4)

class AiScriptAnalyser:

	def __init__(self):
		self.requestedLabels = [] # list of labels that have yet to be found
		self.encounteredLabels = [] # list of labels that have been encountered
		self.canContinue = False

	def request_label(self, identifier):
		if identifier != 0:
			if not (identifier in self.encounteredLabels) and not (identifier in self.requestedLabels):
				self.requestedLabels.append(identifier)

	def encounter_label(self, identifier):
		if identifier != 0:
			if identifier in self.requestedLabels:
				self.requestedLabels.remove(identifier)

			self.encounteredLabels.append(identifier)

	def set_can_continue(self, canContinue):
		self.canContinue = canContinue

	def is_nothing_left(self):
		return len(self.requestedLabels) == 0 and not self.canContinue

CONDITIONAL_OP_MAP = {
	0: '>',
	1: '>=',
	2: '==',
	3: '<=',
	4: '<',
	5: '!='
}

def get_00_conditional(anal, instr):
	condition = instr.sarg0
	target    = instr.sarg2

	compared  = instr.larg1
	value     = instr.larg0

	anal.request_label(target)
	anal.set_can_continue(True)

	return 'goto {} if {} {} {}'.format(
		target if target != 0 else 'start',
		name_address(compared),
		CONDITIONAL_OP_MAP[condition],
		value
	)

def get_01_asmcall(anal, instr):
	funcAddr = instr.larg1
	funcArg  = instr.larg2

	anal.set_can_continue(True)

	return 'asmc {}({})'.format(name_address(funcAddr), name_address(funcArg))

def get_02_chai(anal, instr):
	newAi1 = instr.sarg0
	newAi2 = instr.sarg1

	anal.set_can_continue(True)

	return 'chai ai1 = {}, ai2 = {}'.format(
		newAi1 if newAi1 != 0xFF else 'unchanged',
		newAi2 if newAi2 != 0xFF else 'unchanged'
	)

def get_03_goto(anal, instr):
	target = instr.sarg2

	anal.request_label(target)

	return 'goto {}'.format(target if target != 0 else 'start')

def get_04_action_on(anal, instr):
	chance = instr.sarg0
	target = instr.larg0

	anal.set_can_continue(True)

	return 'targetted_action {}%, {}'.format(chance, name_character(target))

def get_05_action(anal, instr):
	chance = instr.sarg0
	ignoreList = instr.larg1

	anal.set_can_continue(True)

	if ignoreList != 0:
		return 'action {}% ignoring <list:{}>'.format(
			chance,
			name_address(ignoreList)
		)

	return 'action {}%'.format(chance)

def get_06_nop(anal, instr):
	anal.set_can_continue(True)
	return 'nop06'

def get_07_action_in_place(anal, instr):
	chance = instr.sarg0

	anal.set_can_continue(True)

	return 'action_inplace {}%'.format(chance)

def get_0B_staff(anal, instr):
	anal.set_can_continue(True)
	return 'staff_action'

def get_0D_move_to_char_until_in_range(anal, instr):
	maxDanger = instr.sarg1
	charId    = instr.larg0

	anal.set_can_continue(True)

	return 'move_to_until_inrange max_danger = {}, character = {}'.format(maxDanger, name_character(charId))

def get_0E_nop(anal, instr):
	anal.set_can_continue(True)
	return 'nop0E'

def get_10_loot(anal, instr):
	anal.set_can_continue(True)
	return 'loot'

def get_12_move_to_enemy(anal, instr):
	maxDanger = instr.sarg1
	ignoreList = instr.larg1

	anal.set_can_continue(True)

	if ignoreList != 0:
		return 'move_to_enemy max_danger = {}, ignoring <list:{}>'.format(
			maxDanger,
			name_address(ignoreList)
		)

	return 'move_to_enemy max_danger = {}'.format(maxDanger)

def get_13_move_to_unk(anal, instr):
	maxDanger = instr.sarg1
	ignoreList = instr.larg1

	anal.set_can_continue(True)

	if ignoreList != 0:
		return 'move_to_unk max_danger = {}, ignoring <list:{}>'.format(
			maxDanger,
			name_address(ignoreList)
		)

	return 'move_to_unk max_danger = {}'.format(maxDanger)

def get_16_move_random(anal, instr):
	anal.set_can_continue(True)
	return 'move_random'

def get_17_escape(anal, instr):
	anal.set_can_continue(True)
	return 'escape'

def get_18_attack_snag_wall(anal, instr):
	anal.set_can_continue(True)
	return 'attack_or_goto_snag_wall'

def get_1A_move_to_terrain(anal, instr):
	maxDanger = instr.sarg1
	terrainList = instr.larg1

	anal.set_can_continue(True)

	return 'move_to_terrain max_danger = {}, terrains = <list:{}>'.format(maxDanger, name_address(terrainList))

def get_1C_label(anal, instr):
	identifier = instr.sarg2

	anal.set_can_continue(True)
	anal.encounter_label(identifier)

	return 'label {}'.format(identifier)

COMMAND_MAP = {
	0: get_00_conditional,
	1: get_01_asmcall,
	2: get_02_chai,
	3: get_03_goto,
	4: get_04_action_on,
	5: get_05_action,
	6: get_06_nop,
	7: get_07_action_in_place,
	11: get_0B_staff,
	13: get_0D_move_to_char_until_in_range,
	14: get_0E_nop,
	16: get_10_loot,
	18: get_12_move_to_enemy,
	19: get_13_move_to_unk,
	22: get_16_move_random,
	23: get_17_escape,
	24: get_18_attack_snag_wall,
	26: get_1A_move_to_terrain,
	28: get_1C_label
}

def disassemble_ai(input):
	anal = AiScriptAnalyser()

	while True:
		instr = AiRawInstruction(input)

		anal.set_can_continue(False)

		yield COMMAND_MAP[instr.code](anal, instr)

		if anal.is_nothing_left():
			break

def main(args):
	if len(args) < 1:
		sys.exit("gib rom!!!")

	romFileName = args[0]

	with open(romFileName, 'rb') as f:
		for i in range(0x15):
			f.seek(0x5A9184 + i * 4)

			aiAddress = read_int(f, 4)
			aiOffset = aiAddress & 0x1FFFFFF

			f.seek(aiOffset)
			print('Ai1 #{}'.format(i))

			for line in disassemble_ai(f):
				print('  {}'.format(line))

			print()

		for i in range(0x13):
			f.seek(0x5A9138 + i * 4)

			aiAddress = read_int(f, 4)
			aiOffset = aiAddress & 0x1FFFFFF

			f.seek(aiOffset)
			print('Ai2 #{}'.format(i))

			for line in disassemble_ai(f):
				print('  {}'.format(line))

			print()

if __name__ == "__main__":
	main(sys.argv[1:])
