
# encode password using below
encoded_pwd=$( echo "pasword" | openssl aes-256-cbc -a -salt -pass pass:password )

# provide below argument to mysql command
args="-A"

# use below mysql string to connect and load into mysql remote database
mysql --user=${username} --host=${remote_hostname} --port=${port_number} --password=$( echo ${encoded_pwd} | openssl aes-256-cbc -d -a -pass pass:password ) --database=${schema_name}  ${args} -vv << EOF > ${capture_output} 2> ${capture_error}
select count(*) from table;
load data local infile '${file}'
ignore into table ${table_name}
fields terminated by '|';
update ${table_name} set tm=now(), up_tm=tm, mod_tm=tm;
EOF

