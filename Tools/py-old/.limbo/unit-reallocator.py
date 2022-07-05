import sys, os

REFERENCE = {
	"FE8U": {
		"unit-lookup": 0x0859A5D0,
		"unit-array": 0x0202BE4C,

		"unit-max-total": 137,
		"unit-max-saved": 111,

		"blue-unit-max-addresses": [
			0x08031718, # in FE8U:08031714 LoadPlayerUnitsFromUnitStack
			0x08031758, # in FE8U:08031754 LoadPlayerUnitsFromUnitStack2
			0x080A5074, # in FE8U:080A5054 SaveGame
			0x080A5174, # in FE8U:080A5128 LoadGame
			0x080A5AB0, # in FE8U:080A5A48 SaveSuspendedGame
			0x080A5C70, # in FE8U:080A5C14 LoadSuspendedGame
			0x080A6476, # in ???
		],

		"green-unit-base-addresses": [
			0x080A5BD8, # in FE8U:080A5A48 SaveSuspendedGame
			0x080A5D78, # in FE8U:080A5C14 LoadSuspendedGame
		],

		"red-unit-base-addresses": [
			0x080A5BD4, # in FE8U:080A5A48 SaveSuspendedGame
			0x080A5D70, # in FE8U:080A5C14 LoadSuspendedGame
		]
	}
}

def main(args):
	if len(args) < 5:
		sys.exit("USAGE: (python3) {} <GAME ID (FE8U)> <blue count> <red count> <green count> [gray count]".format(sys.argv[0]))

	reference = REFERENCE[args[1]]

	if reference == None:
		sys.exit("ERROR: Unsupported game `{}`".format(args[1]))

	def parse_number_argument(arg, argNum, argName):
		try:
			return int(arg, base = 0)

		except ValueError:
			sys.exit('ERROR: argument {} ({}) is "{}" which is not a number!'.format(argNum, argName, arg))

	countBlueSaved  = parse_number_argument(args[2], 1, "blue unit count")
	countRedSaved   = parse_number_argument(args[3], 2, "red unit count")
	countGreenSaved = parse_number_argument(args[4], 3, "green unit count")
	countGraySaved  = parse_number_argument(args[5], 4, "gray unit count") if len(args) > 5 else 0

	countTotalSaved = countBlueSaved + countRedSaved + countGreenSaved + countGraySaved

	if countTotalSaved < reference["unit-max-saved"]:
		sys.stderr.write("WARNING: Using less unit slots than available ({} out of {})!\n".format(countTotalSaved, reference["unit-max-saved"]))

	if countTotalSaved > reference["unit-max-saved"]:
		sys.exit("ERROR: Using more unit slots than there available ({} out of {})!".format(countTotalSaved, reference["unit-max-saved"]))

	countBlueTotal  = countBlueSaved
	countRedTotal   = countRedSaved
	countGreenTotal = countGreenSaved if countGreenSaved > 5 else 5
	countGrayTotal  = countGraySaved if countGraySaved > 5 else 5

	# allocate unused slots
	countLeft = reference["unit-max-total"] - (countBlueTotal + countRedTotal + countGreenTotal + countGrayTotal)

	countBlueTotal  = countBlueTotal  + countLeft // 4
	countRedTotal   = countRedTotal   + countLeft // 4
	countGreenTotal = countGreenTotal + countLeft // 4
	countGrayTotal  = countGrayTotal  + countLeft // 4

	countLeft = reference["unit-max-total"] - (countBlueTotal + countRedTotal + countGreenTotal + countGrayTotal)
	countGreenTotal = countGreenTotal + countLeft

if __name__ == '__main__':
	main(sys.argv)
