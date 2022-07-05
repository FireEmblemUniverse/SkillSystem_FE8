import nightmare, csv, sys, glob, os

def show_exception_and_exit(exc_type, exc_value, tb):
	import traceback

	traceback.print_exception(exc_type, exc_value, tb)
	sys.exit(-1)

def process(nmm, rom, filename):
	headers = [ hex(nmm.offset) ]
	
	for col in nmm.columns:
		headers.append(col.description)
	
	table = [ headers ]

	for row in range(nmm.rowNum):
		rowOffset = nmm.offset + row*nmm.rowLength
		
		try:
			thisRow = [nmm.entryNames[row]]
		
		except IndexError:
			thisRow = [hex(row)]
		
		for col in range(nmm.colNum):
			entry = nmm.columns[col]
			currentOffset = rowOffset + entry.offset
			dt = int.from_bytes(rom[currentOffset:currentOffset+entry.length], 'little', signed=entry.signed)
			
			if (entry.base==16):
				dt = hex(dt)
			
			thisRow.append(dt)
		
		table.append(thisRow)
	# rom.close()
	
	with open(filename, 'w') as myfile:
		wr = csv.writer(myfile, quoting=csv.QUOTE_ALL, lineterminator='\n')
		wr.writerows(table)
	print("Wrote to " + filename)

def main():
	sys.excepthook = show_exception_and_exit
	
	try:
		inputROM = sys.argv[1]
	
	except IndexError:
		pass
		# root = tk.Tk()
		# root.withdraw()
		# inputROM = filedialog.askopenfilename(filetypes=[("GBA files",".gba"),("All files",".*")],initialdir=os.getcwd(),title="Select ROM to rip data from")
	
	(dirname, filename) = os.path.split(inputROM)
	
	# if (dirname):
	#	 moduleList = glob.glob(dirname + '/**/*.nmm',recursive=True) #a list of all nightmare modules in the directory
	# else:
	#	 moduleList = glob.glob('**/*.nmm',recursive=True)
	
	moduleList = glob.glob('**/*.nmm',recursive=True)
	for inputNMM in moduleList:
		outputname = inputNMM.replace(".nmm",".csv") #let's just keep the same file name for now
		# print("Module:\t" + inputNMM)
		# print("Output:\t" + outputname)
		try:
			nmm = nightmare.NightmareTable(inputNMM)
		
			with open(inputROM, 'rb') as rom_file:
				rom = bytes(rom_file.read())
		
			process(nmm, rom, outputname)
		except AssertionError as e:
			print("Error in " + inputNMM+":\n" + str(e))

if __name__ == '__main__':
	main()
