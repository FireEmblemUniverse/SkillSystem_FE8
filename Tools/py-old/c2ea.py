import sys, csv, os
import nightmare, pfind

# This version of c2ea is deprecated and shouldn't be used anymore.
# Kept because the code here is still cleaner than the main c2ea
# So this would be good reference when we'll want to make main c2ea cleaner

def show_exception_and_exit(exc_type, exc_value, tb):
	import traceback

	traceback.print_exception(exc_type, exc_value, tb)
	sys.exit(-1)

def get_entry_ea_code(nmmentry):
	"""takes the nmm entry object and returns the appropriate EA code"""

	if nmmentry.length == 4:
		if (nmmentry.offset % 4) == 0:
			return "WORD"

		else:
			return "WORD2"

	elif nmmentry.length == 2:
		if (nmmentry.offset % 2) == 0:
			return "SHORT"

		else:
			return "SHORT2"

	else:
		return "BYTE"

def processed_lines(csvName, nmmName, romName):
	"""Takes a csv and generates corresponding event lines. Requires a nmm with the same name in the same folder."""

	macroName = "_C2EA_{}".format(os.path.split(os.path.splitext(csvName)[0])[1].replace(' ', '_'))

	nmm = nightmare.NightmareTable(nmmName)

	currentLength = 0 # because we start with nothing
	macroArgs     = []
	macroCodes    = []

	for i, entry in enumerate(nmm.columns):
		argString = "_ARG{:03d}".format(i)
		macroArgs.append(argString)

		if entry.length != currentLength:
			currentLength = entry.length
			macroCodes.append(get_entry_ea_code(entry))

		macroCodes[len(macroCodes)-1] += ' {}'.format(argString)

	yield '#define {0}({1}) "{2}"'.format(macroName, ",".join(macroArgs), ";".join(macroCodes))

	with open(csvName, 'r') as myfile:
		table = csv.reader(myfile)

		offsetCell = next(table)[0]

		inline = False
		repoint = False

		tableName = ''

		try:
			offset = int(offsetCell, base = 0)

			# offsetCell contains a number

			yield "PUSH"
			yield "ORG ${:X}".format(offset)

		except ValueError:
			# offsetCell does not contain a number

			inline = True

			if offsetCell.strip()[0:6]=="INLINE":
				tableName = offsetCell[6:].strip()
				repoint = True

			else:
				tableName = offsetCell.strip()
				repoint = False

			yield 'ALIGN 4'
			yield '{}:'.format(tableName)

		for row in table:
			if len(row) < (nmm.colNum + 1):
				sys.exit("{} contains a row with not enough entries!".format(csvName))

			line = "{}(".format(macroName)

			for entry, data in zip(nmm.columns, row[1:]):
				# output.extend(int(data, 0).to_bytes(entry.length, 'little', signed=entry.signed))

				if data == '':
					sys.exit("ERROR: `{}` contains a blank cell!".format(csvName))

				# If it is a standard entry type, we can allow complex expressions and what not
				if (entry.length == 4) or (entry.length == 2) or (entry.length == 1):
					line += '({}),'.format(data)

				# If it is another kind of entry, we need to unpack the cell value into individula bytes
				else:
					bytelist = int(data, base = 0).to_bytes(entry.length, 'little', signed = entry.signed)
					line += ' '.join(map(lambda x: '${:X}'.format(x), bytelist))
					line += ','

			yield line[:-1] + ')'
		
		if inline and repoint:
			yield "PUSH"

			for offset in pfind.pointer_offsets(romName, 0x8000000 | nmm.offset):
				yield "ORG ${:X}".format(offset)
				yield "POIN {}".format(tableName)

		if repoint or not inline:
			yield "POP"

def main():
	sys.excepthook = show_exception_and_exit

	if len(sys.argv) < 4:
		sys.exit("Usage: {} <CSV File> <Output Event File> <Reference ROM>".format(sys.argv[0]))

	if not os.path.exists(sys.argv[1]):
		sys.exit("File `{}` doesn't exist".format(sys.argv[1]))

	if not os.path.exists(sys.argv[3]):
		sys.exit("File `{}` doesn't exist".format(sys.argv[3]))

	csvName = sys.argv[1]
	nmmName = sys.argv[1].replace(".csv", ".nmm")
	romName = sys.argv[3]

	with open(sys.argv[2], 'w') as f:
		f.writelines(map(lambda line: line+'\n', processed_lines(csvName, nmmName, romName)))

if __name__ == '__main__':
	main()
