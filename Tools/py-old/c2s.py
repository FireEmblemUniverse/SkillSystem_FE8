#/usr/bin/env python3

import sys, csv, os
import nightmare

# This is experimental, do not use
# Takes a csv and a nmm and throws out asm
# like c2ea, but without the ea part
# well, without a lot of things actually

def gen_lines(csvName, nmmName):
	nmm = nightmare.NightmareTable(nmmName)

	with open(csvName, 'r') as csvFile:
		table = csv.reader(csvFile)

		tableName = next(table)[0]

		yield '.global {}'.format(tableName)
		yield '{}:'.format(tableName)

		for row in table:
			if len(row) < (nmm.colNum + 1):
				sys.exit("{} contains a row with not enough entries!".format(csvName))

			for entry, data in zip(nmm.columns, row[1:]):
				if (data == None) or (data == ''):
					sys.exit("{} contains a blank cell!".format(csvName))

				if entry.length == 4:
					yield '.4byte {}'.format(data)

				elif entry.length == 2:
					yield '.2byte {}'.format(data)

				elif entry.length == 1:
					yield '.byte {}'.format(data)

				else:
					# Handle arbitrary field size

					bytelist = int(data, 0).to_bytes(entry.length, 'little', signed = entry.signed)
					yield '.byte {}'.format(', '.join(map(lambda x: '0x{:X}'.format(x), bytelist)))

if __name__ == '__main__':
	csvFile = sys.argv[1]
	nmmFile = sys.argv[2]

	for line in gen_lines(csvFile, nmmFile):
		print(line)
