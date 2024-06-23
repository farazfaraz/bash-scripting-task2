#!/usr/bin/bash

function usage {
 cat <<EOF
 $0 <option> <path>
 --path --> path for doing backup 
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


# Define the source and destination directories
backup_dir="/tmp/backup"

# Create a timestamp for the backup directory
timestamp=$(date +"%Y%m%d%H%M%S") # This ensures that each backup has a unique identifier.
new_backup_dir="$backup_dir/$timestamp"

# Create the new backup directory
mkdir -p "$new_backup_dir" #-p flag ensures that any necessary parent directories are also created.

# Perform the incremental backup
#--listed-incremental="$backup_dir/latest.snapshot": This option tells tar to create an incremental backup. It uses the latest.snapshot file to keep track of changes since the 
#last backup. If the latest.snapshot file does not exist, a full backup is performed and a new snapshot file is created.
tar --create --listed-incremental="$backup_dir/latest.snapshot" --file="$new_backup_dir/backup.tar" "$path"
# Update the latest symlink
#No matter how many backups you create, latest will always point to the most recent one.
#-s: Creates a symbolic (soft) link instead of a hard link. A soft link is a pointer to another file or directory.
#-f: Forces the removal of any existing file or link with the same name (latest in this case) before creating the new symlink.
#-n: If the destination is a directory, treat the symlink as a file to avoid recursive linking issues.
ln -sfn "$new_backup_dir" "$backup_dir/latest"
