
# IN_PARM	: 
#	1 put/get
#	2 server ip 
#	3 sftp port 
#	4 sftp user
#	5 sftp pwd 
#	6 file name/pattern
#	7 file path

cur_date=$( date +%d%m%Y_%H%M%S )

expect <<EOF
spawn sftp -oPort=${3} ${4}@${2}
expect "${4}@${2}'s password:"
send "${5}\r"
expect "sftp>"
send "cd ${7}\r"
expect "sftp>"
send "${1} ${6}\r"
expect "sftp>"
send "rename ${6} ${6}_${cur_date}\r"
expect "sftp>"
send "quit\r"
expect eof
EOF
