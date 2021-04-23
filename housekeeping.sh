
# Skeleton for Purging, backup and compress functionality script
# create two config files: one for purging configs and another for backup and compress

function delete_process_file {
  # delete process file which created for currently running executable
}

function check_process {
  # check whether existing executable already running
}

function find_files {
  # find files based on configurations and create audit file before taking action on those files
}

function purge_files {
  # take action on found files and create post-audit file
}

function backup_and_compress {
  # implement back and compress functionality based on parameters passed
}

function wrap_backup_and_compress {
  # read back and compress configurations and config files and extrac  and pass parameters to backup_and_compress function
}

