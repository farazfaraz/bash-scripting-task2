# My Project
#### Extend the [bash-scripting-task1](https://github.com/farazfaraz/bash-scripting-task1) script to do incremental backups instead of getting everything from scratch. You're able to use other tools like Restic, Kopia, etc.
#### What is the difference between full backup and incremental backup?
##### A full backup is a complete copy of all files and directories in a given directory or filesystem. It creates a point-in-time snapshot of the entire data set. Full backups are typically performed periodically, such as daily or weekly, to ensure that all data is backed up. On the other hand, an incremental backup only backs up the files that have changed since the last backup, whether it’s a full backup or another incremental backup. This means that incremental backups are faster and require less storage space compared to full backups. Incremental backups are typically performed more frequently, such as hourly or daily, to capture the changes made to the data since the last backup.
##### You can use cron to run your backup script at specific intervals, such as daily or hourly.
# use the project
* Download incremental-backup.sh and then change the path of the variable backup_dir based on where you want to save your backups
* Transform the project into an executable project : chmod +x BachupToStorage.sh
* run the program passing a path as an argument where you want to do backup: ./BackupToStorage.sh --path /your-path
* If you want to schedule incremental backups using cron open the crontab file for editing by the following command:
```
crontab -e
```
* Add the following entry to schedule a daily incremental backup at 2:00 AM:
```
0 2 * * * /path/to/backup_script.sh >> /path/to/backup_log.txt 2>&1
```
* Save and exit the crontab file.
