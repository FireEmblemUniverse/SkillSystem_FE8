import nightmare, csv, sys, glob, os, re

def showExceptionAndExit(exc_type, exc_value, tb):
    import traceback
    traceback.print_exception(exc_type, exc_value, tb)
    input("Press Enter key to exit.")
    sys.exit(-1)

def genIdentifierEntries(names):
    """
    Filters entry list of an nmm to contain names suitable for EA/C identifiers.
    """
    
    # dict mapping names to how many times they've come up
    # this is used to prevent duplicate names
    repeatDict = {}

    for name in names:
        newName = re.sub(r'\W+', '', name)
        
        if newName != "":
            if newName in repeatDict:
                # if name in repeat dict, rename name to "[name][count]", and increment count

                count = repeatDict[newName] + 1
                repeatDict[newName] = count
                
                newName = "{}{}".format(newName, count)
            
            else:
                # add name to dict
                repeatDict[newName] = 1
        
        yield newName

def genTableRows(nmm, rom):
    # First cell is offset of table in ROM
    headers = [hex(nmm.offset)]
    
    # Generate header row (contains field descriptions)
    for col in nmm.columns:
        headers.append(col.description)
    
    yield headers

    for row in range(nmm.rowNum):
        # rowOffset is the offset in ROM of the row data
        rowOffset = nmm.offset + row*nmm.rowLength
        
        # First cell is row/entry name
        try:
            thisRow = [nmm.entryNames[row]]
            
            if thisRow[0] == "":
                thisRow[0] = hex(row)
        
        except IndexError:
            thisRow = [hex(row)]
        
        for entry in nmm.columns:
            # currentOffset is offset in ROM of current field data
            currentOffset = rowOffset + entry.offset
            
            # get int from data
            dt = int.from_bytes(rom[currentOffset:currentOffset+entry.length], 'little', signed = entry.signed)
            
            if (entry.base == 16):
                dt = hex(dt)
            
            thisRow.append(dt)
        
        yield thisRow

def getDefineEntryDefinition(name, value):
    # "#define Name Index"
    return "#define {} 0x{:X}\n".format(name, value)

def getAssignEntryDefinition(name, value):
    # "Name = Index"
    return "{} = 0x{:X}\n".format(name, value)

def getEnumEntryDefinition(name, value):
    # "    Name = Index,"
    return "    {} = 0x{:X},\n".format(name, value)

def genEntryDefinitions(nmm, getEntryDefinition):
    for i in range(nmm.rowNum):
        try:
            name = nmm.entryNames[i]
        
        except IndexError:
            # We reached end of names entries
            break
        
        if name == "":
            # Name is empty
            continue
        
        yield getEntryDefinition(name, i)

def main():
    import argparse

    sys.excepthook = showExceptionAndExit

    parser = argparse.ArgumentParser(description = 'Convert NMM files to CSV files using a ROM as reference.')
    
    # Input options
    parser.add_argument('rom', nargs='?', help = 'reference ROM.')
    parser.add_argument('-f', '--folder', help = 'folder to search for NMMs in.')
    
    # Entry List output options
    parser.add_argument('-e', '--enums', action = 'store_true', help = 'translates entry lists to C enums.')
    parser.add_argument('-d', '--defines', action = 'store_true', help = 'translates entry lists to defines.')
    parser.add_argument('-a', '--assigns', action = 'store_true', help = 'translates entry lists to `name = id` expressions.')
    
    args = parser.parse_args()
    
    if args.rom == None:
        import tkinter as tk
        from tkinter import filedialog

        root = tk.Tk()
        root.withdraw()

        args.rom = filedialog.askopenfilename(
            title = "Select ROM to rip data from",
            initialdir = os.getcwd(),
            filetypes = [
                ("GBA files", ".gba"),
                ("All files", ".*")
            ]
        )

    # generating module list
    if args.folder == None:
        moduleList = glob.glob('**/*.nmm', recursive = True)
    
    else:
        moduleList = glob.glob(args.folder + '/**/*.nmm', recursive = True)
    
    enableGenerateEntryLists = args.enums or args.defines or args.assigns
    
    # read ROM bytes
    with open(args.rom, 'rb') as f:
        romBytes = bytes(f.read())
    
    for nmmFile in moduleList:
        csvFile = nmmFile.replace(".nmm", ".csv") #let's just keep the same file name for now

        try:
            nmm = nightmare.NightmareTable(nmmFile)
                
        except AssertionError as e:
            # NMM is malformed
            print("Couldn't parse NMM `{}`:\n  {}".format(nmmFile, str(e)))
            continue

        if enableGenerateEntryLists:
            # Regen entry names to make them suitable as C/EA identifers
            nmm.entryNames = [x for x in genIdentifierEntries(nmm.entryNames)]
            
            entryFile = nmmFile.replace('.nmm', '.def')
            
            # Write entry list file
            with open(entryFile, 'w') as f:
                if args.enums:
                    f.write('enum {\n')
                    f.writelines(genEntryDefinitions(nmm, getEnumEntryDefinition))
                    f.write('};\n')
                
                elif args.defines:
                    f.writelines(genEntryDefinitions(nmm, getDefineEntryDefinition))
                    
                elif args.assigns:
                    f.writelines(genEntryDefinitions(nmm, getAssignEntryDefinition))
                
                print("Wrote to `{}`".format(entryFile))
        
        # Write CSV
        with open(csvFile, 'w') as f:
            wr = csv.writer(f, quoting = csv.QUOTE_ALL, lineterminator = '\n')
            wr.writerows(genTableRows(nmm, romBytes))

            print("Wrote to `{}`".format(csvFile))

    input("Press Enter to continue.")

if __name__ == '__main__':
    main()
