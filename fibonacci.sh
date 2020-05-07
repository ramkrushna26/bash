#!/bin/bash

####################################################################################
#             Name:         fibonacci.sh                                           #
#             Description:  Generating pattern                                     #
#             Usage:        ./scriptname                                           #
#             Author:       Ramkrushna Bolewar                                     #
#             Version:      1.0                                                    #
####################################################################################
#                              Version History                                     #
####################################################################################
# Version |   Date   |                Change                       | Author        #
####################################################################################
#   1.0   | 15/05/17 |            Initial Version                  | Ramkrushna    #
####################################################################################


# variables

read -p "Enter the number : " input
export input
export count=0
first=0
second=1

# functions

fibonacci() {
        echo -ne " $first "
        count=$(( $count + 1 ))
        echo -ne " $second "
        count=$(( $count + 1 ))

        while [ $input -ne $count ]
        do
                temp=$(( $first + $second ))
                first=$(( $second ))
                second=$(( $temp ))
                echo -ne " $second "
                count=$(( $count + 1 ))
        done
}

if [ $input -eq 1 ];then
        echo $first
elif [ $input -gt 1 ];then
        fibonacci $input
	echo ""
else
        echo "Entered wrong number, I guess you dont want to play. BYE"
        break;
fi

echo -e "I am Batman!"
