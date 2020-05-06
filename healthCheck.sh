#!/bin/bash

#
# Ramkrushna Bolewar
#
# This script checks does the system health check
#

dash="------------------------------------------"

color='y'
green="\033[0;32m"
yellow="\033[1;33m"
nc="\033[0;m"

if [ $color == 'y' ]
then
	gcolor="\e[47;32m --- Okay/Healthy \e[0m"
	wcolor="\e[43;31m --- Warning \e[0m"
	ccolor="\e[47;31m --- Criticle \e[0m"

else
	gcolor=" --- Okay/Healthy "
	wcolor=" --- Warning "
	ccolor=" --- Criticle "
fi

# System Information

echo -e $dash
echo -e "$yellow System Info $nc"
echo -e $dash

hostname &> /dev/null && echo -e "$green Hostname $nc : $(hostname)"

lsb_release -d &> /dev/null && echo -e "$green Operating System $nc : $(lsb_release -d | awk -F: '{ print $2 }' | sed -e 's/^[ \t]*//' )"

uname -o &> /dev/null && echo -e "$green OS Type $nc : $(uname -o)"

uname -r &> /dev/null && echo -e "$green Kernal Version $nc : $(uname -r)"

uname -p &> /dev/null && echo -e "$green Architecture $nc : $(uname -p)"

hostname -I &> /dev/null && echo -e "$green IP Address $nc : $(hostname -I)"

echo -e $dash
echo -e "$yellow Logged in Users $nc"
echo -e $dash

who

echo -e $dash
echo -e "$yellow Disk Usage $nc"
echo -e $dash

echo -e "$green$(df -PTh | grep -w "Filesystem") $nc"
echo -e "$(df -PTh|egrep -iw "ext4|ext3|xfs|/dev/sda*"|grep -v "loop")"
#echo "$(df -PTh|egrep -iw "ext4|ext3|xfs|/dev/sda*"|grep -v "loop"|sort -k6n|awk '!seen[$1]++)"

echo -e $dash
echo -e "$yellow Memory & Swap Utilization $nc"
echo -e $dash

echo -e "$green$(free -h | grep -w "total") $nc"
echo -e "$green$(free -h | grep  "Mem" | awk -F: '{ print $1 }')$nc:$(free -h | grep "Mem" | awk -F: '{ print $2 }')"
echo -e "$green$(free -h | grep  "Swap" | awk -F: '{ print $1 }')$nc:$(free -h | grep "Swap" | awk -F: '{ print $2 }')"
