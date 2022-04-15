
from pathlib import Path


#import re

import glob
import os

# `cwd`: current directory is straightforward
cwd = Path.cwd()

# if we are in the `helper_script.py`
mod_path = Path(__file__).parent


relative_path_1 = 'dmp/'

# search dmp files with the name "*.dmp"
pattern = "*.dmp"

path = (mod_path / relative_path_1 / pattern).resolve()
result = glob.glob("dmp/*.dmp")
#print(path)
#print(result)

# List of the files that match the pattern
for file_name in result:
    old_name = file_name
    new_name = file_name.rsplit('By', 1)[0]
    new_name = new_name.rsplit('.', 1)[0] + ".dmp"
    try:
        os.rename(old_name, new_name)
    except FileExistsError:
        os.remove(new_name)
        os.rename(old_name, new_name)
    #print(new_name)



