#!/bin/bash

backupPath=$(ls ~/OC/ | grep -E "backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -n | tail -1 )
lastBackupDate=$(echo $lastBackupPath | sed 's/^backup-//')
lastBackupPath=~/OC/$backupPath

echo "$lastBackupDate $lastBackupPath"

if [[ -z $lastBackupPath ]]
then
    echo "Backup don't exist. I kill myself :)"
    kill -9 $$
fi

if [[ ! -d ~/OC/restore ]]
then
    echo "~/OC/restore don't exist"
    mkdir ~/OC/restore
else
    echo "~/OC/restore exist"
    kill -9 $$
fi

for file in $(ls $lastBackupPath | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
    #echo "${lastBackupPath}/${file} ~/OC/restore/${file}"
    cp $lastBackupPath"/"$file ~/OC/restore/$file
done
