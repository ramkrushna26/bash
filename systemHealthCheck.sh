#!/bin/bash

#
# Ramkrushna Bolewar
#
# This script checks does the system health check
#

dash="--------------------------------------"

color='y'
green="\033[0;32m"
yellow="\033[1;33m"
nc="\033[0;m"

echo -e "${green}Started: $(date +'%d-%b-%Y %H:%M:%S') $nc"

# System Information

echo -e $dash
echo -e "$yellow System Info $nc"
echo -e $dash

hostname &> /dev/null && echo -e "${green}Hostname $nc : $(hostname)"

lsb_release -d &> /dev/null && echo -e "${green}Operating System $nc : $(lsb_release -d | awk -F: '{ print $2 }' | sed -e 's/^[ \t]*//' )"

uname -o &> /dev/null && echo -e "${green}OS Type $nc : $(uname -o)"

uname -r &> /dev/null && echo -e "${green}Kernal Version $nc : $(uname -r)"

uname -p &> /dev/null && echo -e "${green}Architecture $nc : $(uname -p)"

hostname -I &> /dev/null && echo -e "${green}IP Address $nc : $(hostname -I)"

# System load and users load

echo -e $dash
echo -e "$yellow System Load & Users Load $nc"
echo -e $dash

uptime &> /dev/null && echo -e "${green}System Uptime $nc : $(uptime | awk -F, '{ print $1 }')"
uptime &> /dev/null && echo -e "${green}Number of Users $nc : $(uptime | awk -F, '{ print $2 }')"
uptime &> /dev/null && echo -e "${green}Average Load $nc : $(uptime | awk -F, '{ print $3 $4 $5 }' | awk -F: '{ print $2 }')"

echo -e ""
echo -e "${green}Logged in Users $nc"
 who

# Disk space Utilization

echo -e $dash
echo -e "$yellow Disk Usage $nc"
echo -e $dash

echo -e "$green$(df -PTh | grep -w "Filesystem") $nc"
echo -e "$(df -PTh|egrep -iw "ext4|ext3|xfs|/dev/sda*"|grep -v "loop")"
#echo "$(df -PTh|egrep -iw "ext4|ext3|xfs|/dev/sda*"|grep -v "loop"|sort -k6n|awk '!seen[$1]++)"

# Memory & Swap Utilization

echo -e $dash
echo -e "$yellow Memory & Swap Utilization $nc"
echo -e $dash

echo -e "$green$(free -h | grep -w "total") $nc"
echo -e "$green$(free -h | grep  "Mem" | awk -F: '{ print $1 }')$nc:$(free -h | grep "Mem" | awk -F: '{ print $2 }')"
echo -e "$green$(free -h | grep  "Swap" | awk -F: '{ print $1 }')$nc:$(free -h | grep "Swap" | awk -F: '{ print $2 }')"

# Checking for Zombie Processes

echo -e $dash
echo -e "$yellow Zombie Processes $nc"
echo -e $dash

ps -eo stat | grep -w Z 1>&2 > /dev/null
if [ $? -eq 0 ]
then
	ps -eo stat | grep -w Z 1>&2 > /dev/null && echo -e "${green}Number of Zombie processes $nc : $(ps -eo stat, pid, ppid, user, args | grep -w Z)"
else
	echo -e "No zombie processes!"
fi

echo -e $dash
echo -e "$yellow Top 5 CPU Intensive Processes $nc"
echo -e $dash

echo -e "${green}$(ps -eo stat,pid,ppid,user,%mem,%cpu,args --sort=-%cpu | head -1) $nc"
ps -eo stat,pid,ppid,user,%mem,%cpu,args --sort=-%cpu | head -11 | tail -10

echo -e $dash
echo -e "${green}Ended: $(date +'%d-%b-%Y %H:%M:%S') $nc"

