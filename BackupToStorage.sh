#!/usr/bin/bash

function usage {
 cat <<EOF
 $0 <option> <path>
 --path --> path for doing backup and save it on AWS storage
EOF
}

if [[ $# -ne 2 ]];then
 usage
 exit 1
fi

case $1 in
 --path)
  path=$(realpath $2)
  shift 2
 ;;
 *)
  echo "ERROR: Wrong Argument!"
  exit 1
 ;;
esac

echo "PATH: $path"
#checks if the aws command is available in the system's PATH and if it is executable. If the aws command is found, command -v aws would normally 
#print the path to the aws executable. However, since the output is redirected to /dev/null, no output is produced.
# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
  echo "AWS CLI not found, please install it."
  exit 1
fi

# Define backup file name and S3 bucket
backup_file="/tmp/backup_$(basename $path)_$(date +%Y%m%d%H%M%S).tar.gz"
s3_bucket="backup-from-bash"

# Compress the directory
#STEPS:1) Change to the directory containing the target directory. 2) Create the archive of the target directory, compress it, and save it to the specified location.
#-c:Create a new archive,-z: Compress the archive using gzip,-f $backup_file:Specify the filename of the archive.$backup_file is a variable containing the path where the archive will be saved.
tar -czf $backup_file -C $(dirname $path) $(basename $path) #---> tar -czf /tmp/backup_bash-scripting_20240620.tar.gz -C /home/faraz/Desktop bash-scripting

if [[ $? -ne 0 ]]; then
  echo "ERROR: Failed to create backup archive."
  exit 1
fi

echo "Backup file created: $backup_file"

#If you did not configure your AWS CLI first --> type 'aws configure' on your terminal
# Upload the backup to S3
aws s3 cp $backup_file s3://$s3_bucket/

if [[ $? -ne 0 ]]; then
  echo "ERROR: Failed to upload backup to S3."
  exit 1
fi

echo "Backup successfully uploaded to s3://$s3_bucket/"

# Cleanup local backup file
rm -f $backup_file

if [[ $? -ne 0 ]]; then
  echo "WARNING: Failed to delete local backup file."
else
  echo "Local backup file deleted."
fi

