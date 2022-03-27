#!/bin/bash

IFS=$'\n'

echo "Which feature do you fancy today: 6.4, 6.5, 6.6, 6.7, 6.8, Custom(1) or Custom(2) ? "
read feature

cd ..
absolute_path=$(pwd)
cd Project01

## FEATURE 6.4
if [ "$feature" -eq 4 ]; then
        filesize=$( du -a -h $absolute_path/ | grep -v '^-' | sort -r -h )
        echo "$filesize"


## FEATURE 6.5
elif [ "$feature" -eq 5 ]; then

	echo "Which file extension would you like to search for:"

	read count

	number=$(find $absolute_path/  -type f -name "*.$count" )
	total=$(echo "$number" | wc -l)

	if [ -z "$number" ]; then
		echo "No such file found!"
	else

		echo "Number of files in repository is $total"
	fi


## FEATURE 6.6
elif [ "$feature" -eq 6 ]; then
        echo "Which word would you like to search for: ?"
        read word

        if [ ! -f  "$word.log" ]; then
                touch "$word.log"
	else
		search=$(find $absolute_path/ -type f -name "*.py")
                touch "$word.log" > "$word.log"
                echo "$(grep -E '^#' $search | grep -w $word)" >> "$word.log"
        fi


## FEATURE 6.7
elif [ "$feature" -eq 7 ]; then

	locate=$(find $absolute_path/ -type f -name "*.sh")

	echo "Would you like to Change or Restore?"
	read prompt

        if [ ! $prompt = "Change" ] && [ ! $prompt = "Restore" ] ; then
                echo "Wrong input detected! Please choose 'Change' or 'Restore'"
                read prompt
	fi

        if [ $prompt = "Change" ] ; then
		if [ -f "permissions.log" ] ; then
			rm "permissions.log"
			touch "permissions.log"
		fi

		for files in $locate
		do
			echo "The original permissions for the file are:" $(stat -c %a $files) " " $(ls -l $files | cut -c1-10) " " $files >> "permissions.log"
			permissions=$(ls -l $files)
			user=$(echo $permissions | cut -c3)
			group=$(echo $permissions | cut -c6)
			world=$(echo $permissions | cut -c9)

			if [ $user = "w" ] ; then
				chmod u+x $files
			elif [ ! $user = "w" ] ; then
				chmod u-x $files
			fi


			if [ $group = "w" ] ; then
				chmod g+x $files
			elif [ ! $group = "w" ] ; then
				chmod g-x $files
			fi


			if [ $world = "w" ] ; then
				chmod o+x $files
			elif [ ! $world = "w" ] ; then
				chmod o-x $files
			fi


		done
		echo "File permissions have been Changed!"

	elif [ $prompt = "Restore" ] ; then
		if [ -f permissions.log ] ; then
			while read line
			do
				x=$(echo $line | cut -c44-46)
				y=$(echo $line | cut -b 63- )
				chmod $x $y
			done < permissions.log
			echo "File permissions have been Restored!"
		fi

	fi


## FEATURE 6.8
elif [ "$feature" -eq 8 ] ; then
	echo "Would you like to Backup or Restore?"
	read prompt

	if [ ! $prompt = "Backup" ] && [ ! $prompt = "Restore" ] ; then
		echo "Wrong input detected! Please choose 'Backup' or 'Restore'"
		read prompt
	fi

	if [ $prompt = "Backup" ] ; then
		if [ ! -d backup ] ; then
			mkdir backup
		else
			rm -r backup
			mkdir backup
		fi

		search=$(find $absolute_path/ -type f -name "*.tmp")

		for files in $search
		do
			cp $files backup
			cd backup
			echo $files >> "restore.log"
			rm $files
			cd ..
		done
		echo "File(s) have been moved to 'backup' directory!"


	elif [ $prompt = "Restore" ] ; then
		cd backup

		if [ ! -f "restore.log" ] ; then
			echo "ERROR 404: File not found (non-existing)"
		else
			while read path
			do

				filen=$(basename $path)
				echo "File name: $filen"

				dirn=$(dirname $path)
				echo "Directory name: $dirn"


				mv $filen $dirn
			done < restore.log
			echo "File(s) have been restored to original location!"
		fi
	fi

## CUSTOM FEATURE 1
elif [ "$feature" -eq 1 ] ; then

	echo "Which word would you like to search for ?"
	read word


	search=$(find $absolute_path/ -type f)
	total=$(grep -rl "$word" $search)
	count=$($total | wc -l)
	echo "Number of files with '$word' in repository is:"
	echo "$total"

	for files in $total
	do

		r=$(ls -l $files | cut -c2)
		w=$(ls -l $files | cut -c3)

		if [ $r = "r" ] && [ $w = "w" ] ; then
			echo "File is owned!"
		else
			echo "File is NOT owned!"
		fi

	done


## CUSTOM FEATURE 2
elif [ "$feature" -eq 2 ] ; then

	locate=$(find $absolute_path/ -type f -name "*.txt")

	echo "Files are: $locate"

	for files in $locate
	do
		chmod 777 $files
	done
	echo "You now have ALL file permissions!"

else
        echo "Incorrect feature detected, Please input (4) or (5) or (6) or (7) or (8) or (Custom1) or (Custom2)"
        ./project_analyze.sh
fi
