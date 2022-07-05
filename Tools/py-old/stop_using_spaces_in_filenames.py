import sys, os, re

# this dict maps old names to names after renaming
# for paths, only the final component of path is different
# all other components are *already renamed* (even for keys)
RENAMING_MAP = {}

# If this is False, then actual renaming occurs
# Otherwise it's just listing the changes
IS_SIMULATION = True

# Call this to rename a path
# (don't wirte to RENAMING_MAP directly)
def rename_path(old, new):
	global RENAMING_MAP

	RENAMING_MAP[old] = new

	if os.path.exists(old):
		if not IS_SIMULATION:
			os.renames(old, new)

		return True

	return False

def this_is_not_an_exercise():
	"""
	THIS FUNCTION IS DANGEROUS
	"""

	global IS_SIMULATION
	IS_SIMULATION = False

def is_simulation():
	return IS_SIMULATION

def path_splitext_full(path):
	finalExt = ''

	base, ext = os.path.splitext(path)

	while ext != '':
		finalExt = ext + finalExt
		base, ext = os.path.splitext(base)

	return (base, finalExt)

def get_path_components(path):
	"""
	takes a path and returns its components in order
	"""

	result = []

	# remove lead and tail path separators
	path = path.strip(os.path.sep + (os.path.altsep if os.path.altsep else ''))

	# no do while :(

	while True:
		(path, tail) = os.path.split(path)

		if tail == '':
			break

		result.append(tail)

	result.reverse()
	return result

def get_renamed_components(components):
	result = []

	prevPath = ''

	for component in components:
		path = os.path.join(prevPath, component)

		if path in RENAMING_MAP:
			path = RENAMING_MAP[path]
			component = os.path.basename(path)

		result.append(component)
		prevPath = path

	return result

def join_path_components(components):
	result = ''

	for component in components:
		result = os.path.join(result, component)

	return result

def get_renamed_path(path):
	return join_path_components(get_renamed_components(get_path_components(path)))

def process_file(path, renamer):
	"""
	given a path, processes its filename and returns the new file name
	the returned filename may not be the renamed filename! if this is a simulation, the name is unchanged.
	renamer is a function that takes a path component and returns the renamed version
	"""

	# precond: path is the current path to file, accounting for already renamed entities

	path = os.path.normpath(path)
	components = get_path_components(path)

	if components[0] == '..':
		raise Exception() # TODO: better error

	prevPath = ''

	for i, component in enumerate(components):
		component = components[i]
		thisPath = os.path.join(prevPath, component)

		alreadyRenamed = False

		for old, new in RENAMING_MAP.items():
			if old == thisPath:
				thisPath = RENAMING_MAP[thisPath]
				component = os.path.basename(thisPath)

				alreadyRenamed = True
				break

			elif new == thisPath:
				alreadyRenamed = True
				break

		if not alreadyRenamed:
			renamed = renamer(component)

			if component != renamed:
				newPath = os.path.join(prevPath, renamed)

				rename_path(thisPath, newPath)

				thisPath = newPath
				component = renamed

		prevPath = thisPath
		components[i] = component

	if (not IS_SIMULATION):
		# if the file has been renamed, we will want to pass return renamed file
		return join_path_components(components)

	else:
		return path

# From here onwards, I don't want to see any reference to the renaming globals
# All the actual replacement logic is done in the functions above.

# a list of two string tuples mapping extentions to extentions
# this is to process potentially generated files
EXT_PATTERN_MAP = []

def declare_pattern(ext1, ext2):
	global EXT_PATTERN_MAP

	if ext1 != ext2:
		EXT_PATTERN_MAP.append((ext1, ext2))
		EXT_PATTERN_MAP.append((ext2, ext1))

def fix_path_expression(path, base = ''):
	path = os.path.normpath(path.strip('"').replace('\\', '/'))

	if os.name != 'nt' and (not os.path.exists(os.path.join(base, path))):
		# find correct path in a case-incesitive way
		# this isn't needed on windows as ntfs is already case-incensitive

		components = get_path_components(path)

		currentPath = base

		for i, component in enumerate(components):
			lComponent = component.lower()

			try:
				for file in os.listdir(currentPath if currentPath != '' else '.'):
					if file.lower() == lComponent:
						component = file
						break

			except OSError:
				break

			currentPath = os.path.join(currentPath, component)
			components[i] = component

		path = join_path_components(components)

	return path

def rename_from_ea_preproc_recursive(path, renamer):
	includedFiles = []
	incbinnedFiles = []

	# TODO: handle ., .., and tail comments

	lines = []

	with open(path, 'r') as f:
		for iLine, line in enumerate(f.readlines()):
			lines.append(line)

			match = re.match(r'(.*\*\/)?(\s*)\#(?P<directive>include|incbin)\s+(?P<file_expr>(".+")|(\S+))', line)

			if match:
				directive = match.group('directive')
				file      = fix_path_expression(match.group('file_expr'), os.path.dirname(path))

				fileStart = match.start('file_expr')
				fileEnd   = match.end('file_expr')

				if directive == 'include':
					includedFiles.append((iLine, (fileStart, fileEnd), file))

				elif directive == 'incbin':
					incbinnedFiles.append((iLine, (fileStart, fileEnd), file))

		f.close()

	for iLine, incExprRange, file in includedFiles:
		fullOldPath = os.path.join(os.path.dirname(path), file)
		fullNewPath = process_file(fullOldPath, renamer)

		try:
			if os.path.exists(fullNewPath):
				rename_from_ea_preproc_recursive(fullNewPath, renamer) # recursion!

			relNewPath = os.path.relpath(fullNewPath, os.path.dirname(path)).replace('\\', '/')
			lines[iLine] = lines[iLine][:incExprRange[0]] + '"{}"'.format(relNewPath) + lines[iLine][incExprRange[1]:]

		except OSError:
			print("Failed to process included file: {}".format(fullNewPath), file = sys.stderr)

		base, ext = path_splitext_full(fullOldPath)

		for ext1, ext2 in EXT_PATTERN_MAP:
			if ext1 == ext:
				otherFile = base + ext2

				if os.path.exists(otherFile):
					process_file(otherFile, renamer)

	for iLine, incExprRange, file in incbinnedFiles:
		fullOldPath = os.path.join(os.path.dirname(path), file)
		fullNewPath = process_file(fullOldPath, renamer)

		try:
			relNewPath = os.path.relpath(fullNewPath, os.path.dirname(path)).replace('\\', '/')
			lines[iLine] = lines[iLine][:incExprRange[0]] + '"{}"'.format(relNewPath) + lines[iLine][incExprRange[1]:]

		except OSError:
			print("Failed to process included file: {}".format(fullNewPath), file = sys.stderr)

		base, ext = path_splitext_full(fullOldPath)

		for ext1, ext2 in EXT_PATTERN_MAP:
			if ext1 == ext:
				otherFile = base + ext2

				if os.path.exists(otherFile):
					process_file(otherFile, renamer)

	if not is_simulation():
		with open(path, 'w') as f:
			f.writelines(lines)
			f.close()

def name_to_words(name):
	result = []

	for bigWord in re.findall(r'[^\s\-_]+', name): # get parts splitted with ' ', '_' or '-' 
		words = re.findall(r'[A-Z]?[a-z0-9]*', bigWord) # get all word-like parts (where only the first letter can be capitalized)

		# add to result while merging successive all-uppercase parts (so that [`E`, `A`] becomes `EA`; but [`FE8`, `Capture`] stays unchanges)
		for i in range(len(words)):
			if i < (len(words)-1) and words[i].upper() == words[i] and words[i+1].upper() == words[i+1]:
				words[i+1] = words[i] + words[i+1]

			else:
				if words[i] != '':
					result.append(words[i])

	return result

def file_renamer_replace_spaces_with_underscores(name):
	return re.sub(r' ', '_', name)

def file_renamer_remove_spaces(name):
	return re.sub(r' ', '', name)

def file_renamer_to_snake_case(name):
	base, ext = path_splitext_full(name)

	words = name_to_words(base)

	for i, word in enumerate(words):
		words[i] = word.lower()

	return '_'.join(words) + ext

def file_renamer_to_snake_case_capitalized(name):
	base, ext = path_splitext_full(name)

	words = name_to_words(base)

	for i, word in enumerate(words):
		words[i] = word[0].upper() + word[1:].lower()

	return '_'.join(words) + ext

def file_renamer_to_snake_case_dash_capitalized(name):
	base, ext = path_splitext_full(name)

	words = name_to_words(base)

	for i, word in enumerate(words):
		words[i] = word[0].upper() + word[1:].lower()

	return '-'.join(words) + ext

def file_renamer_to_snake_case_dash(name):
	base, ext = path_splitext_full(name)

	words = name_to_words(base)

	for i, word in enumerate(words):
		words[i] = word.lower()

	return '-'.join(words) + ext

def file_renamer_to_pascal_case(name):
	base, ext = path_splitext_full(name)

	words = name_to_words(base)

	for i, word in enumerate(words):
		words[i] = word[0].upper() + word[1:]

	return ''.join(words) + ext

def file_renamer_to_camel_case(name):
	base, ext = path_splitext_full(name)

	words = name_to_words(base)

	for i, word in enumerate(words):
		if i != 0:
			words[i] = word[0].upper() + word[1:]

	return ''.join(words) + ext

FILE_RENAMER_MAP = {
	'only-remove-spaces': file_renamer_remove_spaces,

	'snake-case': file_renamer_to_snake_case,
	'snake-case-dash': file_renamer_to_snake_case_dash,

	'snake-case-capitalized': file_renamer_to_snake_case_capitalized,
	'snake-case-dash-capitalized': file_renamer_to_snake_case_dash_capitalized,

	'pascal-case': file_renamer_to_pascal_case,
	'camel-case': file_renamer_to_camel_case,
}

def main(argv):
	import argparse

	argParse = argparse.ArgumentParser(description = """Takes one or more event files; processes its filename as well as its included files' filenames recursively and remove spaces from them. An optional "style" can be applied to file names, which will further changes their filename in a consistent way. File extention "patterns" can be defined; which tells this program to look for files with extentions corresponding to the pattern. Pattern format is ".ext1=.ext2=...". To apply changes, pass the "--apply" flag. To review changes, pass the "--list-changes" flag.""")

	argParse.add_argument('files', nargs = '+')

	argParse.add_argument('--style', choices = FILE_RENAMER_MAP.keys(), default = 'only-remove-spaces')
	argParse.add_argument('-p', '--pattern', dest = 'patterns', nargs = '*')

	argParse.add_argument('--apply', action = 'store_true')
	argParse.add_argument('--list-changes', action = 'store_true')

	args = argParse.parse_args(argv)

	if args.apply:
		if 'y' == input("Are you sure (y/n)?"):
			if 'y' == input("You may want to back up your stuff before doing this. Are you really sure (y/n)?"):
				if 'y' == input("This may break everything. Are you positively 120% sure (y/n)?"):
					if 'y' == input("So are we really doing it (y/n)?"):
						this_is_not_an_exercise()

	if args.patterns:
		for patternExpr in args.patterns:
			exts = patternExpr.split('=')

			for i, exti in enumerate(exts):
				for extj in exts[i:]:
					declare_pattern(exti, extj)

	for file in args.files:
		renamer = FILE_RENAMER_MAP[args.style]

		rename_from_ea_preproc_recursive(
			process_file(
				file,
				renamer
			),
			renamer
		)

	if args.list_changes:
		for old, new in sorted(RENAMING_MAP.items(), key = lambda t: t[0]):
			print("{} => {}".format(old, new))

if __name__ == '__main__':
	main(sys.argv[1:])
