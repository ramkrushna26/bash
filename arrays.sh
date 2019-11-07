
arr=(one two three 4 5)

echo -e " array item : " ${arr[*]}
echo -e " array size : " ${#arr[*]}

echo " < Indexing array > "
for index in ${!arr[*]}
do
        printf "%2d : %s\n" $index ${arr[$index]}
        #echo -e $index " : " ${arr[$index]}
done
