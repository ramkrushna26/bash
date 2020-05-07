#!/bin/bash

#
# Ramkrushna Bolewar
#
# This scripts check the status of servers 
#

green="\033[0;32m"
red="\033[0;31m"
yellow="\033[0;33m"
nc="\033[0;m"

serverList="./config/$(basename $0 .sh).conf"
#echo $serverList

if [ -f $serverList ]
then
	while read line
	do
		ping -c 1 $line 1>&2 > /dev/null
		if [ $? -eq 0 ]
		then
			echo -e "${green}Reachable via ping $nc: $line"
		else
			echo -e "${red}Unreachable via ping $nc: $line"
		fi
	done < $serverList
else
	echo -e "Config File does not exist: $serverList "
fi
