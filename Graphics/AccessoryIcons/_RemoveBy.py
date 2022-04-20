
from pathlib import Path


#import re

import glob
import os


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



