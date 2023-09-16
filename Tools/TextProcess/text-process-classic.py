
# TPC CHANGELOG:

# 1.0:
# - Initial Release

# 2.0:
# - Add support for #define <name> <repl>
#   - Invoke using either `{<name>}` or `[<name>]`
#   - Nesting invocations supported
# - Add support for C++-style comments ('// <comment>' at the end of lines)

# modified by Bly for use with Scraiza's narrow font hack and MintX's extension
from pathlib import Path
import os, sys, re
INPUT_ENCODING = "utf-8"
OUTPUT_ENCODING = "utf-8"

def show_exception_and_exit(exc_type, exc_value, tb):
	import traceback
	
	traceback.print_exception(exc_type, exc_value, tb)
	sys.exit(-1)

# create dict for narrow text
#NARROW_DICT = {"a":"[0x81]", "b":"[0x82]", "c":"[0x83]", "d":"[0x84]", "e":"[0x85]", "f":"[0x86]", "g":"[0x87]", "h":"[0x88]", "k":"[0x8A]", "n":"[0x8B]", "o":"[0x8C]", "p":"[0x8D]", "q":"[0x8E]", "r":"[0x8F]", "s":"[0x90]", "t":"[0x89]", "u":"[0x96]", "v":"[0x97]", "x":"[0x98]", "y":"[0x99]", "z":"[0x9A]", "A":"[0x9B]", "B":"[0x9C]", "C":"[0x9D]", "D":"[0x9E]", "E":"[0x9F]", "F":"[0xA0]", "G":"[0xA2]", "H":"[0xA3]", "J":"[0xA4]", "K":"[0xA5]", "L":"[0xA6]", "O":"[0xA7]", "P":"[0xA8]", "Q":"[0xA9]", "R":"[0xAC]", "S":"[0xAD]", "U":"[0xAE]", "V":"[0xAF]", "X":"[0xB0]", "Y":"[0xB1]", "Z":"[0xB2]", " ":"[0xBC]", "0":"[0xC0]", "1":"[0xC1]", "2":"[0xC2]", "3":"[0xC3]", "4":"[0xC4]", "5":"[0xC5]", "6":"[0xC6]", "7":"[0xC7]", "8":"[0xC8]", "9":"[0xC9]", ".":"[0xCA]", ",":"[0xCB]", ":":"[0xCC]", "+":"[0xCD]", "-":"[0xCE]", "/":"[0xCF]", "(":"[0xD0]", ")":"[0xD1]", "'":"[0xD4]", "\"":"[0xD5]"}
NARROW_DICT = {"a":"[0xe1][0xb5][0x83]", "b":"[0xe1][0xb5][0x87]", "c":"[0xe1][0xb6][0x9c]","d":"[0xe1][0xb5][0x88]", "e":"[0xe1][0xb5][0x89]", "f":"[0xe1][0xb6][0xa0]", "g":"[0xe1][0xb5][0x8d]","h":"[0xca][0xb0]", "k":"[0xe1][0xb5][0x8f]", "n":"[0xe2][0x81][0xbf]", "o":"[0xe1][0xb5][0x92]","p":"[0xe1][0xb5][0x96]", "q":"[0xe1][0xb5][0xa0]", "r":"[0xca][0xb3]", "s":"[0xcb][0xa2]","t":"[0xe1][0xb5][0x97]", "u":"[0xe1][0xb5][0x98]", "v":"[0xe1][0xb5][0x9b]", "x":"[0xcb][0xa3]","y":"[0xca][0xb8]", "z":"[0xe1][0xb6][0xbb]", "A":"[0xe1][0xb4][0x80]", "B":"[0xca][0x99]","C":"[0xe1][0xb4][0x84]", "D":"[0xe1][0xb4][0x85]", "E":"[0xe1][0xb4][0x87]", "F":"[0xd2][0x93]","G":"[0xc9][0xa2]", "H":"[0xca][0x9c]", "J":"[0xe1][0xb4][0x8a]", "K":"[0xe1][0xb4][0x8b]","L":"[0xca][0x9f]", "O":"[0xe1][0xb4][0x8f]", "P":"[0xe1][0xb4][0x98]", "Q":"[0xc7][0xab]","R":"[0xca][0x80]", "S":"[0xe1][0x82][0xbd]", "U":"[0xe1][0xb4][0x9c]", "V":"[0xe1][0xb4][0xa0]","X":"[0xe1][0x83][0xaf]", "Y":"[0xca][0x8f]", "Z":"[0xe1][0xb4][0xa2]", " ":"[0xDE][0xB0]","0":"[0xe2][0x81][0xb0]", "1":"[0xc2][0xb9]", "2":"[0xc2][0xb2]","3":"[0xc2][0xb3]", "4":"[0xe2][0x81][0xb4]", "5":"[0xe2][0x81][0xb5]","6":"[0xe2][0x81][0xb6]", "7":"[0xe2][0x81][0xb7]", "8":"[0xe2][0x81][0xb8]", "9":"[0xe2][0x81][0xb9]", ".":"[0xDE][0x82]", ",":"[0xDE][0x9B]", ":":"[0xDE][0x98]", "+":"[0xDE][0x88]","-":"[0xDE][0x87]", "/":"[0xDE][0x8A]", "(":"[0xDE][0x86]", ")":"[0xDE][0x89]","'":"[0xDE][0x8B]", "\"":"[0xDE][0x8A]"}







# create dict for narrow text for menus
#NARROW_MENU_DICT = {"a":"[0x81]", "b":"[0x82]", "c":"[0x83]", "d":"[0x84]", "e":"[0x85]", "f":"[0x86]", "g":"[0x87]", "h":"[0x88]", "j":"[0x89]", "k":"[0x8A]", "n":"[0x8B]", "o":"[0x8C]", "p":"[0x8D]", "q":"[0x8E]", "r":"[0x8F]", "s":"[0x90]", "u":"[0x96]", "v":"[0x97]", "x":"[0x98]", "y":"[0x99]", "z":"[0x9A]", "A":"[0x9B]", "B":"[0x9C]", "C":"[0x9D]", "D":"[0x9E]", "E":"[0x9F]", "F":"[0xA0]", "G":"[0xA2]", "H":"[0xA3]", "J":"[0xA4]", "K":"[0xA5]", "L":"[0xA6]", "O":"[0xA7]", "P":"[0xA8]", "Q":"[0xA9]", "R":"[0xAC]", "S":"[0xAD]", "U":"[0xAE]", "V":"[0xAF]", "X":"[0xB0]", "Y":"[0xB1]", "Z":"[0xB2]", " ":"[0xBC]"}
NARROW_MENU_DICT = {"a":"[0xe1][0xb5][0x83]", "b":"[0xe1][0xb5][0x87]", "c":"[0xe1][0xb6][0x9c]","d":"[0xe1][0xb5][0x88]", "e":"[0xe1][0xb5][0x89]", "f":"[0xe1][0xb6][0xa0]", "g":"[0xe1][0xb5][0x8d]","h":"[0xca][0xb0]", "k":"[0xe1][0xb5][0x8f]", "n":"[0xe2][0x81][0xbf]", "o":"[0xe1][0xb5][0x92]","p":"[0xe1][0xb5][0x96]", "q":"[0xe1][0xb5][0xa0]", "r":"[0xca][0xb3]", "s":"[0xcb][0xa2]","t":"[0xe1][0xb5][0x97]", "u":"[0xe1][0xb5][0x98]", "v":"[0xe1][0xb5][0x9b]", "x":"[0xcb][0xa3]","y":"[0xca][0xb8]", "z":"[0xe1][0xb6][0xbb]", "A":"[0xe1][0xb4][0x80]", "B":"[0xca][0x99]","C":"[0xe1][0xb4][0x84]", "D":"[0xe1][0xb4][0x85]", "E":"[0xe1][0xb4][0x87]", "F":"[0xd2][0x93]","G":"[0xc9][0xa2]", "H":"[0xca][0x9c]", "J":"[0xe1][0xb4][0x8a]", "K":"[0xe1][0xb4][0x8b]","L":"[0xca][0x9f]", "O":"[0xe1][0xb4][0x8f]", "P":"[0xe1][0xb4][0x98]", "Q":"[0xc7][0xab]","R":"[0xca][0x80]", "S":"[0xe1][0x82][0xbd]", "U":"[0xe1][0xb4][0x9c]", "V":"[0xe1][0xb4][0xa0]","X":"[0xe1][0x83][0xaf]", "Y":"[0xca][0x8f]", "Z":"[0xe1][0xb4][0xa2]", " ":"[0xDE][0xB0]"}

RE_NON_ALPHANUM = re.compile(r'\W')
RE_DIRECTIVE    = re.compile(r"^#([a-zA-Z]\w*)\s+(.+)")
RE_DEFINE_PARTS = re.compile(r"^(\w+)\s+(.+)")
RE_MACRO_INVOKE = re.compile(r'\{(\w+)\}|\[(\w+)\]')
RE_TEXT_ENTRY 	= re.compile(r"^#\s*([0x[0-9a-fA-F]+|#)\s*(\w+)?\s*(({?[*^])|})?$", re.I) # added third group for checking narrow
RE_NARROW_SEC	= re.compile(r"([*^]{[^}]*})")
RE_BRACKETS		= re.compile(r"(\[[^]]*\])")

def macroize_name(name):
	return RE_NON_ALPHANUM.sub('_', name).upper()

class TextProcessError(Exception):

	def __init__(self, fileName, lineNumber, errDesc):
		self.fileName   = fileName
		self.lineNumber = lineNumber
		self.errDesc    = errDesc

class TextEntry:

	def __init__(self, text, stringId, definition = None):
		self.text       = text
		self.stringId   = stringId
		self.definition = definition

	def get_unique_identifier(self):
		return self.definition if self.definition else "{:03X}".format(self.stringId)

	def get_pretty_identifier(self):
		if self.definition:
			return "{:03X} {}".format(self.stringId, self.definition)

		return "{:03X}".format(self.stringId)

class ParseFileError(Exception):

	def __init__(self, textEntry, errDesc):
		self.textEntry = textEntry
		self.errDesc   = errDesc

class Preprocessor:

	def __init__(self, doTrace):
		self.doTrace = doTrace  # boolean
		self.definitions = {}   # { string: string }
		self.includeSet = set() # { string }

	def strip_comment(self, string):
		i = string.find('//')

		if i >= 0:
			return string[:i]

		return string

	def preprocess(self, fileName):
		if fileName in self.includeSet:
			sys.stderr.write("WARNING: file `{}` was already included once, ignoring.\n".format(fileName))
			return None

		self.includeSet.add(fileName)

		if self.doTrace:
			sys.stderr.write("TRACE: [preprocess] opening `{}`\n".format(fileName))

		with open(fileName, 'r', encoding=INPUT_ENCODING) as f:
			for iLine, line in enumerate(f.readlines()):
				line = self.strip_comment(line)
				stripped = line.strip()

				m = RE_DIRECTIVE.match(stripped)

				if m:
					directive = m.group(1).strip().lower()

					if directive == 'include':
						# include directive

						includee = m.group(2).strip()

						if (includee[0] == '"'):
							includee = includee.strip('"')

						dirpath = os.path.dirname(fileName)

						if len(dirpath) > 0:
							includee = os.path.join(dirpath, includee)

						for otherLine in self.preprocess(includee):
							yield otherLine

					elif directive == 'define':
						m2 = RE_DEFINE_PARTS.match(m.group(2).strip())

						if not m2:
							raise TextProcessError(fileName, iLine+1, "Bad define! Replacement string is probably missing.")

						defname = m2.group(1)
						defvalu = m2.group(2)

						if (defvalu[0] == '"'):
							defvalu = defvalu.strip('"')

						self.definitions[defname] = defvalu

					else:
						sys.stderr.write('WARNING: {}:{}: What is a "#{}"? is this is comment? consider using "//" for comments instead!\n'.format(
							fileName, iLine+1, directive))

				else:
					yield (fileName, iLine, self.expand_macros(line))

	def _get_expanded_expr(self, m):
		defname = m.group(0)[1:-1]

		if defname in self.definitions:
			return self.expand_macros(self.definitions[defname])

		return m.group(0)

	def expand_macros(self, string):
		return RE_MACRO_INVOKE.sub(lambda m: self._get_expanded_expr(m), string)

def generate_text_entries(lines, doTrace):
	"""takes a compiled file and returns a list of individual text entries"""

	result = []

	currentStringId = 0

	currentText = None
	currentDefinition = None

	# for checking narrow
	narrow = False
	menu = False
	constantNarrow = False
	constantMenu = False
	lastNarrow = False

	for (fileName, iLine, line) in lines:
		l = line.strip()

		if currentText == None: # no current text, reading entry header
			if l == "":
				next # Skip empty lines

			else:
				match = RE_TEXT_ENTRY.match(l)

				if not match:
					raise TextProcessError(fileName, iLine+1, "expected entry header!")

				if match.group(1) == '#': # if no ID given, use the previous one + 1
					currentStringId = currentStringId+1

				else:
					currentStringId = int(match.group(1), base = 0)


				currentDefinition = match.group(2)
				currentText = ""

				if match.group(3) is not None:
					if '*' in match.group(3):
						narrow = True
						menu = False
					elif '^' in match.group(3):
						narrow = True
						menu = True
					if narrow or constantNarrow:
						if '{' in match.group(3):
							constantNarrow = True
							constantMenu = menu
						elif '}' in match.group(3):
							lastNarrow = True

		else:
			if constantNarrow: # narrow block
				line = narrowText(line, constantMenu)
			elif narrow: # narrow entry
				line = narrowText(line, menu)
			elif RE_NARROW_SEC.search(line): # check for narrow section
				sections = RE_NARROW_SEC.split(line)
				line = ""
				for section in sections:
					if section.startswith('^'):
						line += narrowText(section[2:-1], True)
					elif section.startswith('*'):
						line += narrowText(section[2:-1], False)
					else:
						line += section

			currentText += line

			if l[-3:] == "[X]": # Line ends in [X] (end of text entry)
				result.append(TextEntry(currentText, currentStringId, currentDefinition))

				if doTrace:
					sys.stderr.write("TRACE: [generate_text_entries] read {}\n".format(result[-1].get_pretty_identifier()))

				currentText = None
				currentDefinition = None
				narrow = False

				if lastNarrow: # done with a narrow block
					constantNarrow = False
					lastNarrow = False

	return result

def narrowText(line, menuToggle):
	sections = RE_BRACKETS.split(line)
	line = "";
	for section in sections:
		if section.startswith('['):
			line += section
		elif menuToggle:
			for c in section:
				line += NARROW_MENU_DICT.get(c,c)
		else:
			for c in section:
				line += NARROW_DICT.get(c,c)
	return line

def generate_definitions_lines(name, textEntries):
	yield "// Text Definitions generated by text-process\n"
	yield "// Do not edit!\n\n"

	yield "#ifndef TEXT_DEFINITIONS_{}\n".format(name)
	yield "#define TEXT_DEFINITIONS_{}\n\n".format(name)

	for entry in textEntries:
		if entry.definition:
			yield "#define {} ${:03X}\n".format(entry.definition, entry.stringId)

	yield "\n#endif // TEXT_DEFINITIONS_{}\n".format(name)

def generate_text_binary(parseFileExe, textEntry, sourceFile, targetFile):
	import subprocess as sp

	result = sp.run([parseFileExe, sourceFile, "--to-stdout"], stdout = sp.PIPE)

	if result.stdout[:6] == b"ERROR:":
		os.remove(sourceFile)
		raise ParseFileError(textEntry, result.stdout[6:].strip().decode("utf-8"))

	with open(targetFile, 'wb') as f:
		f.write(result.stdout)

def main(args):
	import argparse

	argParse = argparse.ArgumentParser()

	argParse.add_argument('input', help = 'input text file')
	argParse.add_argument('--installer', default = 'Install Text Data.event', help = 'name of the installer event file to produce')
	argParse.add_argument('--definitions', default = 'Text Definitions.event', help = 'name of the definitions event file to produce')
	argParse.add_argument('--parser-exe', default = None, help = 'name/path of the parser executable')
	argParse.add_argument('--depends', default = None, nargs='*', help = 'files that text depends on (typically ParseDefinitions.txt)')
	argParse.add_argument('--force-refresh', action = 'store_true', help = 'pass to forcefully refresh generated files')
	argParse.add_argument('--verbose', action = 'store_true', help = 'print processing details to stdout')

	arguments = argParse.parse_args(args)

	inputPath     = arguments.input
	outputPath    = arguments.installer
	outputDefPath = arguments.definitions
	parserExePath = arguments.parser_exe
	forceRefresh  = True if arguments.force_refresh else False
	verbose       = True if arguments.verbose else False

	timeThreshold = 0.0

	if not arguments.depends:
		# Hacky thing to automatically depend on ParseDefinitions.txt if the parser is ParseFile

		if parserExePath and "ParseFile" in parserExePath:
			if os.path.exists("ParseDefinitions.txt"):
				arguments.depends = ["ParseDefinitions.txt"]

	if arguments.depends:
		timeThreshold = max([os.path.getmtime(filename) for filename in arguments.depends])

	sys.excepthook = show_exception_and_exit

	if not os.path.exists(inputPath):
		sys.exit("`{}` doesn't exist".format(inputPath))

	(cwd, inputFile) = os.path.split(inputPath)
	inputName = os.path.splitext(inputFile)[0]

	# Read the entries

	if verbose:
		sys.stderr.write("TRACE: [global] start reading input\n")

	entryList = []

	macroizedInputName = macroize_name(inputPath)

	hasParser = parserExePath and os.path.exists(parserExePath)

	try:
		usedStringIds   = []
		usedDefinitions = []

		for entry in generate_text_entries(Preprocessor(verbose).preprocess(inputPath), verbose): # create separate files for each text entry
			if entry.stringId in usedStringIds:
				sys.stderr.write("WARNING: Duplicate entry for text Id {:03X}! (ignoring)\n".format(entry.stringId))

				if entry.definition:
					sys.stderr.write("NOTE: Second entry was defined as `{}`\n".format(entry.definition))

				continue

			usedStringIds.append(entry.stringId)

			if entry.definition and (entry.definition in usedDefinitions):
				sys.stderr.write("WARNING: Duplicate entry definition {}! (ignoring)\n".format(entry.definition))

				continue

			entryList.append(entry)

	except TextProcessError as e:
		sys.exit("ERROR: {}:{}:\n  {}".format(e.fileName, e.lineNumber, e.errDesc))

	# Write the entries

	# Doing it late to avoid leaving the generated files half done
	# (Otherwise make will consider them updated even if they're bad)

	textFolder = os.path.join(cwd, ".TextEntries")

	if verbose:
		sys.stderr.write("TRACE: [global] start generating output\n")

	if not os.path.exists(textFolder):
		os.mkdir(textFolder)

	try:
		with open(outputPath, 'w') as f:
			f.write("// Text Data Installer generated by text-process\n")
			f.write("// Do not edit! (or do but it won't be of any use)\n\n")

			f.write("#ifndef TEXT_INSTALLER_{}\n".format(macroizedInputName))
			f.write("#define TEXT_INSTALLER_{}\n\n".format(macroizedInputName))

			f.write("#include \"Tools/Tool Helpers.txt\"\n")
			f.write("#include \"{}\"\n\n".format(os.path.relpath(outputDefPath, os.path.dirname(outputPath))))

			f.write("{\n\n")

			for entry in entryList:
				textFileName  = os.path.join(textFolder, "{}{}.fetxt".format(inputName, entry.get_unique_identifier()))
				textDataLabel = "__TEXTPROCESS{:03X}".format(entry.stringId)
				dataFileName = "{}.dmp".format(textFileName)

				# Check if file exists with the same content
				# This is to prevent make to rebuild files that depend on this
				# As it would not have changed

				textNeedsUpdate = True
				textModifyTime = 0.0

				if not forceRefresh:
					if os.path.exists(textFileName):
						textModifyTime = os.path.getmtime(textFileName)

						with open(textFileName, 'r', encoding=OUTPUT_ENCODING) as tf:
							if str(tf.read()) == entry.text:
								textNeedsUpdate = False

					if textModifyTime < timeThreshold:
						textNeedsUpdate = True

				# Write text data

				if textNeedsUpdate:
					if verbose:
						sys.stderr.write("TRACE: [write] output `{}`\n".format(textFileName))

					with open(textFileName, 'w', encoding=OUTPUT_ENCODING) as tf:
						tf.write(entry.text)

				# Write parsed data if we have a parser

				if hasParser:
					if not os.path.exists(dataFileName) or textNeedsUpdate or os.path.getmtime(dataFileName) < textModifyTime:
						if verbose:
							sys.stderr.write("TRACE: [write] update `{}`\n".format(dataFileName))

						generate_text_binary(parserExePath, entry, textFileName, dataFileName)

				# Write include

				f.write("{}:\n".format(textDataLabel))

				if hasParser:
					f.write('#incbin "{}"\n'.format(str(Path(os.path.relpath(dataFileName, os.path.dirname(outputPath))).as_posix())))
				else:
					f.write('#incext ParseFile "{}"\n'.format(str(Path(os.path.relpath(textFileName, os.path.dirname(outputPath))).as_posix())))

				f.write("setText(${:X}, {})\n\n".format(entry.stringId, textDataLabel))

			f.write("}\n\n")

			f.write("#endif // TEXT_INSTALLER_{}\n".format(macroizedInputName))

	except ParseFileError as e:
		os.remove(outputPath)
		sys.exit("ERROR: ParseFile errored while parsing text for {}:\n  {}".format(e.textEntry.get_pretty_identifier(), e.errDesc))

	with open(outputDefPath, 'w') as f:
		f.writelines(generate_definitions_lines(macroizedInputName, entryList))

if __name__ == '__main__':
	main(sys.argv[1:])
