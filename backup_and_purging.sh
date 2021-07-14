
#!/usr/bin/bash

# create two config files: one for purging configs and another for backup and compress

#
#   Script  :   backup and purging
#   Author  :   Ramkrushna Bolewar
#

DATE_TIME="$( date +%Y%m%d_%H%M%S )"
LOG_PATH="/home/ram/logs"
CONF_PATH="/home/ram/conf"
LOG_FILE="${LOG_PATH}/backup_and_purging_${DATE_TIME}.log"
PRE_AUDIT_FILE="${LOG_PATH}/backup_and_purging_pre_audit_${DATE_TIME}.txt"
POST_AUDIT_FILE="${LOG_PATH}/backup_and_purging_post_audit_${DATE_TIME}.txt"
PROCESS_FILE="${LOG_PATH}/backup_and_purging.proc"
PURGE_CONF="${CONF_PATH}/purging.conf"
BACKUP_CONF="${CONF_PATH}/backup.conf"
TMP_BACKUP_FILE="${LOG_PATH}/backup.tmp"

{
echo "[+] Running at : $( date )"
echo "[+] Running on : $( hostname )"

function remove_process_file {
  rm -f ${PROCESS_FILE}
  if { $? -eq 0 }
  then
    echo "[+] Process File Removed : ${PROCESS_FILE} "
   else
    echo "[-] Not Able to Remove Process File (${PROCESS_FILE}). Please Check. Exiting"
    exit 99
   fi
}

function check_running_process {
  if [ -f ${PROCESS_FILE} ]
  then
    echo "[+] Already running instance (${PROCESS_FILE}). Exiting! "
  else
    ps -ef | grep -i ${0} | grep -v grep > ${PROCESS_FILE}
    if [ $? -eq 0 ]
    then
      echo "[+] Process created : ${PROCESS_FILE} "
    else
      echo "[+] Not Able to Create Process File. Exiting!"
      exit 99
    fi
  fi
}

function generate_audit_file {
  if [ -f ${PURGE_CONF} ]
  then
    while read line
    do
      if [[ ${line} = \#* ]] || [[ ${line} = '' ]]
      then
        continue
      fi
      
      PURGE_PATH=$( echo ${line} | awk -F\| '{ print $1 }' )
      PURGE_FILES=$( echo ${line} | awk -F\| '{ print $2 }' )
      RETENTION_PERIOD=$( echo ${line} | awk -F\| '{ print $3 }' )
      
      find ${PURGE_PATH} -type f -name "${PURGE_FILES}" -mtime +${RETENTION_PERIOD} >> ${PRE_AUDIT_FILE}
    done < ${PURGE_CONF}
    echo "[+] Pre Audit File : ${PRE_AUDIT_FILE} "
    echo "[+] Records in Pre Audit File : $( wc -l ${PRE_AUDIT_FILE} | awk -F" " '{ print $1}' ) "
  else
    echo "[-] Not Able to Find Config File: ${PURGE_CONF} "
    remove_process_file
    echo "[-] Exiting!"
  fi
}

function remove_files {
  deleted_file_count=0
  while read line
  do
    #rm -f ${line}
    echo ${line} > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
      deleted_file_count=$((deleted_file_count=1))
      echo "Deleted, ${line}" >> ${POST_AUDIT_FILE}
    else
      echo "Not Deleted, ${line}" >> ${POST_AUDIT_FILE}
    fi
  done < ${PRE_AUDIT_FILE}
  echo "[+] Deleted ${deleted_file_count} files successfully. Please check ${POST_AUDIT_FILE} "

  if [ ${deleted_file_count} -ne $( wc -l ${PRE_AUDIT_FILE} | awk -F" " '{ print $1 }' ) ]
  then
    echo "[-] Not Able to Delete Some Files. Please Check Audit File : ${POST_AUDIT_FILE} "
  fi
}




} >> ${LOG_FILE} 2>&1
