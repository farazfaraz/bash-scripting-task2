# My Project
#### Extend the [bash-scripting-task2]() script to do incremental backups instead of getting everything from scratch. You're able to use other tools like Restic, Kopia, etc.

# use the project
* First of all you have to create a user on aws.amazon.com, write iam on the console and the select on users and create the user. You have to pay attention to add the AmazonS3FullAccess policy to the user, after the user is created you can click on it, then click on the Permissions tab and finally on the Permissions Policy part you can check if you have assined as well the mentioned policy.
* After that go inside the created user click on Security Credentials tab and then in the Acces Key part you have to generate the key, in this way you have Access Key ID and Secret Access Key. 
* Open your terminal and write 'aws configure'. You must use the key generated in this section
* write the following command in the terminal :
```
aws sts get-caller-identity
```
And you have to see an output like the following :
```
197395774601    arn:aws:iam::197395774601:user/faraz   AIDH3FLSYYUI2YAQVBL4L
```
* Write s3 on the console of aws and create a bucket
* Download BachupToStorage.sh and then change the s3_bucket variable to the name that you have selected during the creation of your bucket on aws.
* Transform the project into an executable project : chmod +x BachupToStorage.sh
* run the program passing a path as an argument where you want to do backup: ./BackupToStorage.sh --path /your-path
