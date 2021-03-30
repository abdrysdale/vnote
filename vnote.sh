#! /usr/bin/env bash

# Defines default notes settings
dir="${HOME}/PhD/Notes/"
ext='.md'
default='index.md'

cd ${dir}
# Defaults to default file with no argument
if [ $# -eq 0 ]
then

	filename="${default}"

else

	filename="${1}"

	# Can pass --ls or -l as file name to list tags
	if [ ${filename} = '--ls' ] || [ ${filename} = '-l' ]
	then
		
		# Lists tags
		grep -ho @[a-z]* ${dir}*${ext} | sort | uniq -c | sort -nr

	# Can pass --search-tag or -s to search by tags to edit a file.
	elif [ ${filename} = '--search-tag' ] || [ ${filename} = '-s' ]
	then

		filename=$(grep -Ho @[a-z]* ${dir}*${ext} | rev | cut -d'/' -f 1 | rev | fzf --preview="echo {} | cut -d':' -f 1 | xargs cat" | cut -d : -f 1)
		vim ${dir}${filename}

	else

		# Checks if an extension was passed and defaults to markdown
		if [[ ${1} =~ "." ]]
		then

			filename="$1"
		else
			filename="$1${ext}"
		fi
	
		# Creates the note in the folder
		vim "${dir}${filename}"
	fi 
fi
