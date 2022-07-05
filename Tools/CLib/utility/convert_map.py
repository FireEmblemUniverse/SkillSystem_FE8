#!/usr/bin/env python3

# rename .s file based on .map file

import os, sys


if __name__ == "__main__":
	with open("FE8U-20190316.s", "r") as f:
		prev_s = f.readlines()
	with open("fe8.map", "r") as f:
		decompmap = f.readlines()
	new_s = ''.join(prev_s)
	newmap = []

	for line in decompmap:
		if line.startswith('                0x000000000'):
			tmp = line.replace(' = .', '')
			tmp = tmp.replace('0x000000000', '0x')
			if len(tmp.split()) == 2:
				newmap.append(tmp)

	for line in newmap:
		tmp = line.split()
		# tmp[0] is adr
		# tmp[1] is name
		tmp[0] = tmp[0].lower()
		# check prev_s for adr (or adr+1) and if not, make it SET_FUNC if it starts with sub_ and otherwise SET_DATA
		if tmp[1].startswith('0x'): #handle the case of trying to define 0x20 as 0x800 or something
			break
		matching = [s for s in prev_s if tmp[0][:-1] in s.lower()]
		if matching:
			# it might be off by one for thumb funcs
			for match in matching:
				m = match.split()
				# m[0] is set_func/data, m[1] is name, m[2] is adr
				adr = m[2].lower()
				#ugly but needed for thumb code
				if adr[-1] == '1':
					adr = adr[:-1] + '0'
				if adr[-1] == '3':
					adr = adr[:-1] + '2'
				if adr[-1] == '5':
					adr = adr[:-1] + '4'
				if adr[-1] == '7':
					adr = adr[:-1] + '6'
				if adr[-1] == '9':
					adr = adr[:-1] + '8'
				if adr[-1] == 'b':
					adr = adr[:-1] + 'a'
				if adr[-1] == 'd':
					adr = adr[:-1] + 'c'
				if adr[-1] == 'f':
					adr = adr[:-1] + 'e'
				if adr == tmp[0]:
					# print('match', tmp[0], m[2])
					newline = m
					newline[1] = tmp[1] + ','
					new_s = new_s + ' '.join(newline) + '\n'
		elif tmp[1].startswith('sub_'):
			new_s = new_s + 'SET_FUNC ' + tmp[1] + ', ' + tmp[0] + '\n'
		else:
			new_s = new_s + 'SET_DATA ' + tmp[1] + ', ' + tmp[0] + '\n'

	# for line in prev_s:
	# 	if line.startswith('SET_'):
	# 		tokens = line.split()
	# 		#tokens[0] is SET_FUNC/SET_DATA
	# 		#tokens[1] is the name to be replaced (with a comma on the end)
	# 		#tokens[2] is the address to search for in decompmap
			
	# 		adr = tokens[2][2:].lower() #trim off the 0x

	# 		#ugly but needed for thumb code
	# 		if adr[-1] == '1':
	# 			adr = adr[:-1] + '0'
	# 		if adr[-1] == '3':
	# 			adr = adr[:-1] + '2'
	# 		if adr[-1] == '5':
	# 			adr = adr[:-1] + '4'
	# 		if adr[-1] == '7':
	# 			adr = adr[:-1] + '6'
	# 		if adr[-1] == '9':
	# 			adr = adr[:-1] + '8'
	# 		if adr[-1] == 'b':
	# 			adr = adr[:-1] + 'a'
	# 		if adr[-1] == 'd':
	# 			adr = adr[:-1] + 'c'
	# 		if adr[-1] == 'f':
	# 			adr = adr[:-1] + 'e'

	# 		matching = [s for s in newmap if adr in s]
	# 		for m in matching:
	# 			tmp = m.split()
	# 			if len(tmp) == 2:
	# 				# print(tmp)
	# 				tokens[1] = tmp[1]
	# 				tokens[1] += ','
	# 				break
	# 			# else:
	# 				# print(tmp)

	# 		line = ' '.join(tokens)
	# 		line += '\n'
	# 	new_s = new_s + line

	with open("FE8U-decompatible.s", "w") as f:
		f.write(new_s)