#!/usr/bin/bash

py_path="${HOME}/Python"
cd ${py_path}

echo ${py_path}

if [ -f ${py_path}/.gitignore ]
then
	echo " << TRACKING ALL FILES THROUGH GIT >> "
	git add --all
	while read line
	do
		echo " << UNTRACKING ${line} >> "
		git rm -r --cached ${line}
	done < ${py_path}/.gitignore
else
	echo " << .gitignore does not exist >>"
	exit
fi

echo -n "Do you want to commit?(y/n): "
read in_commit

if [ ${in_commit} == "y" ]
then
	echo "<<commiting>>"
	git commit -m "modified files"
else
	echo "Exiting without commit!"
	exit
fi

echo -n "Do you want to push?(y/n): "
read in_push

if [ ${in_push} == "y"]
then
	echo " << PUSING CODE TO REMOTE >> "
	git push
fi
