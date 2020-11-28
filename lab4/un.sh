#!/bin/bash

file=~/OC/lab4/$1

if [[ $# != 1 ]]
then
    echo "too many parameters"
    kill -9 $$
fi

for i in $(grep -h "$file" ~/OC/.trash.log | awk '{print $1":"$2}')
do
    path=$(echo $i | awk -F ":" '{print $1}')
    backup=$(echo $i | awk -F ":" '{print $2}')
    if [[ $file == $path ]]
    then
        restore=~/OC/.trash/$backup
        if [[ -e $restore ]]
        then
            echo "Do i need to restore the file along the path: $path?"
            read cmd
            if [[ $cmd == "y" ]]
            then
                if [[ -d $(dirname $path) ]]
                then
                    if [[ -e $path ]]
                    then
                        echo "File with name $file already exists."
                        echo "Enter new name for $file:"
                        read newFileName
                        ln $restore "$(dirname $path)/$newFileName"
                    else
                        ln $restore $path
                    fi
                else
                    echo "Directory $(dirname $path) doesn't exsit."
                    ln $restore ~/OC/$1
                    echo "Backup was created at ~/OC/$1"
                fi
                rm -R $restore
                grep -v $backup ~/OC/.trash.log > ~/OC/temp.log
                mv ~/OC/temp.log ~/OC/.trash.log
            else
                echo "ok :) :X :) i kill myself now"
                kill -9 $$
            fi
        fi
    fi
done

if [[ -s ~/OC/.trash.log ]]
then
    echo "~/OC/.trash.log not empty"
else
    echo "~/OC/.trash.log empty"
    rm ~/OC/.trash.log
fi

if [[ `ls ~/OC/.trash | wc -l` -eq 0 ]]
then
    echo "~/OC/.trash empty"
    rmdir ~/OC/.trash
else
    echo "~/OC/.trash not empty"
fi
