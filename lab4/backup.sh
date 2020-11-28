#!/bin/bash
statusOfCreated="false"

backupPath=~/OC/
sourcePath=~/OC/source/
reportFilePath=~/OC/backup-report

if [[ ! -d $sourcePath ]]
then
    echo "source directory doesn't exist"
    kill -9 $$
fi

timeNow=$(date +"%Y-%m-%d")
timeNowInSec=$(date -j -f '%Y-%m-%d' "$timeNow" '+%s')

lastbackupPath=$(ls $backupPath | grep -E "backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -r -k2 | head -1)

if [[ -z $lastbackupPath ]]
then
    let totalTime=8
    echo "backup don't exist"
else
    lastBackupDate=$(echo "$lastbackupPath" | sed "s/^backup-//")
    timeLastBackup=$(date -j -f '%Y-%m-%d' "$lastBackupDate" '+%s')
    let totalTime=$(echo "(${timeNowInSec} - ${timeLastBackup}) / 60 / 60 / 24" | bc)
    echo "backup exist"
fi


if [[ totalTime -le 7 ]]
then
    backupDir=$backupPath$lastbackupPath"/"
    statusOfCreated="false"
else
    mkdir $backupPath"backup-"$timeNow"/"
    backupDir=$backupPath"backup-"$timeNow"/"
    statusOfCreated="true"
fi

if [[ $statusOfCreated != "false" ]]
then
    echo "created in $backupDir with name $backupPath"backup-"$timeNow/" >> $reportFilePath
    for i in $(ls $sourcePath)
    do
        if [[ -f $sourcePath$i ]]
        then
            echo
            cp $sourcePath$i $backupDir$i
            echo  "$sourcePath$i is a file. Copied to $backupDir$i" >> $reportFilePath
        else
            echo "$sourcePath$i is a directory. Can't create restorePoint by directory" >> $reportFilePath
        fi
    done
else
    echo "updating in $backupDir with name $backupPath$lastbackupPath/" >> $reportFilePath
    for i in $(ls $sourcePath)
    do
        if [[ ! -f $sourcePath$i ]]
        then
            echo "$sourcePath$i is a directory. Can't create restorePoint by directory" >> $reportFilePath
        else
            if [[ -f $backupDir$i ]]
            then
                echo "$sourcePath$i also exist in $backupDir$i" >> $reportFilePath
                
                sizeInBackup=$(stat -f%z $sourcePath$i)
                sizeInSource=$(stat -f%z $backupDir$i)
                
                echo "$sizeInSource ==? $sizeInBackup"
                
                if [[ $sizeInSource != $sizeInBackup ]]
                then
                    mv $backupDir$i $backupDir$i.$timeNow
                    cp $sourcePath$i $backupDir$i
                    echo "$backupDir$i was updated to $backupDir$i.$timeNow" >> $reportFilePath
                    echo "$sourcePath$i was coppied to $backupDir$sourcePath$i" >> $reportFilePath
                fi
            else
                cp $sourcePath$i $backupDir$i
                echo "$sourcePath$i was coppied to $backupDir$i" >> $reportFilePath
            fi
        fi
    done
fi
