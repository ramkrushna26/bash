

#!/bin/bash

:<<COMMENT
USER            CPU
1 rock          1 rock
2 paper         2 paper
3 scissor       3 scissor

paper -> rock -> scissor -> paper

1 1, 2 2, 3 3 -> tie
1 2, 2 3, 3 1 -> CPU
1 3, 2 1, 3 2 -> USER

COMMENT
##################################################################

echo " 1. Rock"
echo " 2. Paper"
echo " 3. Scissor"
echo " 0. Exit"

playGame () {
        echo "in method : $user_guess $cpu_guess";
        temp=$user_guess$cpu_guess;

        if [ $user_guess -eq $cpu_guess ];then
                echo " < TIED :: This is the next level of sucking in the GAME > ";
        elif [[ ($temp -eq 12) || ($temp -eq 23) || ($temp -eq 31) ]];then
                echo " < CPU WIN > ";
        else
                echo " < YOU WIN > ";
        fi
}

while true
do
        read -p "Enter the number : " user_guess;
        cpu_guess=$(( RANDOM % (3 - 1 + 1) + 1 ));

        if [ $user_guess -eq 0 ];then
                exit;
        elif [[ (user_guess -le 3) && (user_guess -ge 1) ]];then
                playGame $user_guess $cpu_guess;
        else
                echo "  <<  Enter the options valid option (1, 2, 3 or 4)  >>";
                continue;
        fi
done
