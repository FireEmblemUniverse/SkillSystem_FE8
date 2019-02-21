# NMM format:
# # at line[0] means comment, ignore it.
# blank lines are ignored also.
# decimal is assumed, 0x for hex, 0 for octal (0b for binary?)

# Line 1: file version, ignore it.
# Line 2: file description, ignore it.
# Line 3: address of table, no 0800:0000h
# Line 4: number of entries
# Line 5: length of each entry
# Line 6: text file of entry names, might be useful. Default to numbers if not found
# Line 7: tbl file for text, ignore it.

# Entry format:
# Line 1: Description (use as header row?)
# Line 2: Offset
# Line 3: Length in bytes
# Line 4: Type of data (Only care about H or DU/DS imo)
# Line 5: Text file for descriptions, ignore it for now.
import os

class NightmareTable:

  def __init__(self, path):
    rawFile = open(path, 'r')
    rawText = rawFile.readlines()
    rawFile.close()
    stripped = self.stripText(rawText)
    self.path = path
    self.version = str(stripped[0])
    self.description = str(stripped[1])
    self.offset = parseNum(stripped[2])
    self.rowNum = parseNum(stripped[3])
    self.rowLength = parseNum(stripped[4])
    self.size = self.rowNum * self.rowLength
    self.columns = self.getColumns(stripped)
    self.colNum = len(self.columns)
    self.entryNames = []
    directory = os.path.dirname(path)

    if str(stripped[5]) != "NULL":
      path = os.path.join(directory, str(stripped[5]))
      try:
        with open(path,'r') as textfile:
          self.entryNames = self.getEntryNames(textfile.readlines())
      except FileNotFoundError:
        self.entryNames = []
        print("File not found, ignoring: "+path)

  def getEntryNames(self,lines):
    """receives an array of lines from a txt file and returns an array of entry names"""
    lines = self.stripText(lines)
    #check if the first line is a count, ignore if it is
    try:
      linecount = parseNum(lines[0])
      lines.pop(0)
    except ValueError:
      pass
    return lines

  def stripText(self, rawText):
    """strips comments and blank lines from nmm"""
    strippedText = []
    for line in rawText:
      if line.rstrip():
        if line[0] != '#':
          strippedText.append(line.rstrip()) #also remove newline character
    return strippedText

  def getColumns(self, stripped):
    """returns a list of NightmareEntry objects"""
    noheader = stripped[7:]
    entries = list(chunkify(noheader, 5))
    columns = []
    coverage = [False for x in range(self.rowLength)] #makes a string of bytes covered (0 or 1)
    for entry in entries:
      offset = int(entry[1])
      length = int(entry[2])
      assert offset+length<=self.rowLength, "Error: entry length does not match row length in:\n"+ self.path +"."
      if coverage[offset] == True: # in the case where NMM entries are overlapping
        entry[0] = "##OVERLAP WARNING## " + entry[0]
      for x in range(offset, offset+length):
        coverage[x] = True #set bytes as covered.
      columns.append(NightmareEntry(entry))
    #at this point you have a list [True, True, False] or whatever
    fillerEntries = []
    count = 0
    for offset,val in enumerate(coverage):
      if val==False:
        count += 1
        if count == 1:
          fillerEntry = ["##UNKNOWN##",offset,1,"HEXA","NULL"]
          fillerEntries.append(fillerEntry)
        else:
          fillerEntries[-1][2] = count
      else:
        count = 0
    for fillerEntry in fillerEntries:
      columns.append(NightmareEntry(fillerEntry))
    columns.sort(key=lambda col: col.offset) #sort columns by offset
    return columns

class NightmareEntry:
  description = ''
  offset = 0
  length = 0
  base = 10
  signed = False
  txtfile = None

  def __init__(self,list):
    assert len(list)==5, "Error: Wrong number of lines in entry"
    self.description = list[0]
    self.offset = parseNum(list[1])
    self.length = parseNum(list[2])
    self.checkDataType(list[3])
    if list[4] != "NULL":
      self.txtfile = list[4]

  def checkDataType(self,str):
    """sets base and signed/unsigned."""
    accepted_vals = ["HEXA","NEHU","NEDS","NEDU","NDHU","NDDU"]
    assert str in accepted_vals, "Error: Data Type not accepted: " + str
    if (str == 'HEXA') | (str[2] == 'H'):
      self.base = 16
    if str[3] == 'S':
      self.signed = True

def parseNum(num):
  """0x is hex, 0b is binary, 0 is octal. Otherwise assume decimal."""
  num = str(num).strip()
  base = 10
  if (num[0] == '0') & (len(num) > 1):
    if num[1] == 'x':
      base = 16
    elif num[1] == 'b':
      base = 2
    else:
      base = 8
  return int(num, base)

def chunkify(list,size):
  """splits a list into a list of smaller lists"""
  for i in range (0, len(list), size):
    yield list[i:i+size]
