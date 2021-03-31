#! /usr/bin/env bash

# Defines default notes settings
dir="${HOME}/PhD/Notes/"
ext='.md'
default='index.md'
tag='#'

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
		grep -ho "${tag}[a-z,_,A-Z]\+" ${dir}*${ext} | sort | uniq -c | sort -nr

	# Can pass --search-tag or -s to search by tags to edit a file.
	elif [ ${filename} = '--search-tag' ] || [ ${filename} = '-s' ]
	then

		filename=$(grep -Ho "${tag}[a-z,_,A-Z]\+" ${dir}*${ext} | rev | cut -d'/' -f 1 | rev | fzf --preview="echo {} | cut -d':' -f 1 | xargs cat" | cut -d : -f 1)
		vim ${dir}${filename}

	# Can pass --copy-search-tag or -cs to search by tags to copy a filename.
	elif [ ${filename} = '--copy-search-tag' ] || [ ${filename} = '-cs' ]
	then

		grep -Ho "${tag}[a-z,_,A-Z]\+" ${dir}*${ext} | rev | cut -d'/' -f 1 | rev | fzf --preview="echo {} | cut -d':' -f 1 | xargs cat" | cut -d : -f 1 | tr -d '\n' | xclip -sel clip

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
