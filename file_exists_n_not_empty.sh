
#Checking file exist and it is not empty
if [[ -f file.txt && -s file.txt ]]
then
	echo "file is NOT empty"
else
	echo "file empty"
fi

