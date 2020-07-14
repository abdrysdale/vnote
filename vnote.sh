#!/bin/bash

# Defines default notes settings
dir='~/Dropbox/Notes/'
ext='.md'
default='notes.md'

# Colours
GREEN='\033[0;32m'
NC='\033[0m'

# Line parameters
COLS=$(tput cols)
CENT_COL=$((COLS/2))
SEP="-"
MSG="Notes" 

# Defaults to default file with no argument
if [ $# -eq 0 ]
then

	vim "${dir}${default}"

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
		MSG=$2
		dir="${dir}$2/"

		# Creates a directory if the passed directory doesn't exist
		if [ ! -d ${dir} ]; then
			mkdir $dir
		fi
	fi
	
	# Can pass ls as file name to list notes dir
	if [ ${filename} = 'ls'${ext} ]
	then
		
		# Centeres message
		MSG_LEN=${#MSG}
		MSG_COL=$((CENT_COL - MSG_LEN/2))

		# Prints message to screen
		printf "${GREEN}"
		for i in $(seq 1 $MSG_COL)
		do
			printf "${SEP}"
		done
		printf "${MSG}"
		for i in $(seq 1 $MSG_COL)
		do
			printf "${SEP}"
		done
		printf "${NC}\n"

		# Lists dir
		ls --color=auto ${dir}
	else
		# Creates the note in the folder
		vim "${dir}${filename}"
	fi 
fi
