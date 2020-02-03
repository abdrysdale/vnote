#!/bin/bash

# Defines default notes directory
dir='/home/alex/Dropbox/Notes/'
ext='.md'

# Prints out Notes directory if no arguments are present
if [ $# -eq 0 ]
then

	echo "Notes"
	ls $dir
else

# Checks if an extension was passed and defaults to markdown
if [[ ${1} =~ "." ]]
then

	filename="$1"
else
	filename="$1${ext}"
fi

# Checks if a directory was passed
if [ $# -gt 1 ]
then
	dir="${dir}$2/"

	# Creates a directory if the passed directory doesn't exist
	if [ ! -d ${dir} ]; then
		mkdir $dir
	fi
fi

# Creates the note in the folder
vim "${dir}${filename}"

fi
