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

DIR=$( cd -P $( dirname $0 ) && pwd -P )
DATE_TIME=$( date +%d%m%Y_%H%M%S )

#creating log file

LOG_PATH=<path>
LOG_FILE=${LOG_PATH}/<filename>_${DATE_TIME}.log

touch ${LOG_FILE}
if [ -f ${LOG_FILE} ]
then
	echo -e " Start script from here "
	echo -e "${green}Started: $(date +'%d-%b-%Y %H:%M:%S') $nc" >> ${LOG_FILE}
else
	echo -e " Can not create log file "
	exit
fi

heading {
	echo -e $dash >> ${LOG_FILE}
	echo -e "$yellow ${1} $nc" >> ${LOG_FILE}
	echo -e $dash >> ${LOG_FILE}
}

# System Info
heading "System Info"
hostname &> /dev/null && echo -e "${green} Hostname $nc : $(hostname)"  >> ${LOG_FILE}
lsb_release -d &> /dev/null && echo -e "${green} Operating System $nc : $( lsb_release -d | awk -F: '{ print $2 }' | sed -e 's/^[ \t]*//' )"  >> ${LOG_FILE}
uname -o &> /dev/null && echo -e "${green} OS Type $nc : $(uname -o)"  >> ${LOG_FILE}
uname -r &> /dev/null && echo -e "${green} Kernal Version $nc : $(uname -r)"  >> ${LOG_FILE}
uname -p &> /dev/null && echo -e "${green} Architecture $nc : $(uname -p)"  >> ${LOG_FILE}
hostname -I &> /dev/null && echo -e "${green} IP Address $nc : $(hostname -I)"  >> ${LOG_FILE}

# System load and users load
heading "System load and user load"
uptime &> /dev/null && echo -e "${green} System Uptime $nc : $(uptime | awk -F, '{ print $1 }')"  >> ${LOG_FILE}
uptime &> /dev/null && echo -e "${green} Number of Users $nc : $(uptime | awk -F, '{ print $2 }')"  >> ${LOG_FILE}
uptime &> /dev/null && echo -e "${green} Average Load $nc : $(uptime | awk -F, '{ print $3 $4 $5 }' | awk -F: '{ print $2 }')"  >> ${LOG_FILE}

echo -e ""  >> ${LOG_FILE}
echo -e "${green}Logged in Users $nc"  >> ${LOG_FILE}
 who  >> ${LOG_FILE}

heading "File System Usage"
df -PTh &> /dev/null && echo -e "${green} $( df -PTh | grep -w "FileSystem" ) ${nc}" >> ${LOG_FILE}
df -PTh &> /dev/null && echo -e "${green} $( df -PTh | grep -v "FileSystem" | awk '{ print "" $nf }' ) " >> ${LOG_FILE}

# Disk space Utilization
heading "Disk space utilization"
echo -e "$green$(df -PTh | grep -w "Filesystem") $nc"  >> ${LOG_FILE}
echo -e "$(df -PTh|egrep -iw "ext4|ext3|xfs|/dev/sda*"|grep -v "loop")"  >> ${LOG_FILE}
#echo "$(df -PTh|egrep -iw "ext4|ext3|xfs|/dev/sda*"|grep -v "loop"|sort -k6n|awk '!seen[$1]++)"  >> ${LOG_FILE}

# Memory & Swap Utilization
heading "Memory and Swap Utilization"
echo -e "$green$(free -h | grep -w "total") $nc"  >> ${LOG_FILE}
echo -e "$green$(free -h | grep  "Mem" | awk -F: '{ print $1 }')$nc:$(free -h | grep "Mem" | awk -F: '{ print $2 }')"  >> ${LOG_FILE}
echo -e "$green$(free -h | grep  "Swap" | awk -F: '{ print $1 }')$nc:$(free -h | grep "Swap" | awk -F: '{ print $2 }')"  >> ${LOG_FILE}

# Checking for Zombie Processes
heading "Zombie Processes"
ps -eo stat | grep -w Z 1>&2 > /dev/null
if [ $? -eq 0 ]
then
	ps -eo stat | grep -w Z 1>&2 > /dev/null && echo -e "${green}Number of Zombie processes $nc : $(ps -eo stat, pid, ppid, user, args | grep -w Z)"  >> ${LOG_FILE}
else
	echo -e "No zombie processes!"  >> ${LOG_FILE}
fi

heading "CPU Intensive Processes"
echo -e "${green}$(ps -eo stat,pid,ppid,user,%mem,%cpu,args --sort=-%cpu | head -1) $nc"  >> ${LOG_FILE}
ps -eo stat,pid,ppid,user,%mem,%cpu,args --sort=-%cpu | head -11 | tail -10  >> ${LOG_FILE}

heading "Application related service checks"

echo -e $dash  >> ${LOG_FILE}
echo -e "${green}Ended: $(date +'%d-%b-%Y %H:%M:%S') $nc"  >> ${LOG_FILE}

