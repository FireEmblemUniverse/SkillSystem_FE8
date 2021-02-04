#!/usr/bin/env sh

# This script is what I use to update the entirety of CHAX from an old fe8u.s to a new one.
# It bad, but it work
# -Stan

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <old xyz.o> <new xyz.o>"
	exit 1
fi

# Ensuring the files we want to compare exist
if [ ! -f $1 ]; then
	echo "err, $1 does not exist"
	exit 1
fi

if [ ! -f $2 ]; then
	echo "err, $2 does not exist"
	exit 1
fi

update_script_file=$(mktemp)

# Making the update script
$(dirname $0)/lyn diff $1 $2 | awk '$1 ~ /^>/ { printf "sed -i s^\\\\b%s\\\\b^%s^g $1\n", $2, $3 }' > $update_script_file

# Applying changes
find -type f -name "*.h" -exec sh $update_script_file '{}' \;
find -type f -name "*.c" -exec sh $update_script_file '{}' \;
find -type f -name "*.s" -exec sh $update_script_file '{}' \;

# Removing temp script
rm -f $update_script_file
