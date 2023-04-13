
arr=(one two three 4 5)

echo -e " array item : " ${arr[*]}
echo -e " array size : " ${#arr[*]}

echo " < Indexing array > "
for index in ${!arr[*]}
do
        printf "%2d : %s\n" $index ${arr[$index]}
        #echo -e $index " : " ${arr[$index]}
done


#Declaring array 
declare -a sport=(
	[0]=Cricket
	[1]=Football
	[2]=Hockey
	[3]=Tennis
)
echo ${sport[2]}

for i in {1..10}
do
	num[$i]=$(( $i * $i ))
done

echo ${num[@]}
