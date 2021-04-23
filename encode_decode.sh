my_var="String to encode"

encrypted_pwd=$( echo ${my_var} | openssl aes-256-cbc -a -salt -pass pass:winterIshere )

original_string=$( echo ${encrypted_pwd} | openssl aes-256-cbc -d -a -pass pass:winterIshere )
