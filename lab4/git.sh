#!/bin/bash

if [[ $# != 2 ]]
then
    echo "count of parameters must be equal two"
    kill -9 $$
fi

pathToDir=~/OC/$1/
comand=$2
gitPath=~/OC/$1/as_git

if [[ $comand == "create" ]]
then
    if [[ ! -d $gitPath ]]
    then
        echo "create $gitPath"
        mkdir $gitPath
        
        for i in $(ls $pathToDir)
        do
            currentFileName=$pathToDir$i
            if [[ -f $currentFileName ]]
            then
                if [[ ! -f $gitPath/$i.log ]]
                then
                    echo "0" > $gitPath/$i.log
                    echo $gitPath/$i.log
                fi
                buffer=$(cat $gitPath/$i.log)
                id=$(cat $gitPath/$i.log | head -1)
                id="$(($id + 1))"
                
                ln $currentFileName $gitPath/$i
                cp $currentFileName $gitPath/$i.$id
                
                counter=0
                
                echo $buffer | while read line; do
                counter=$(($counter + 1))
                if [[ $counter == 1 ]]
                then
                    echo $id > $gitPath/$i.log
                else
                    echo $line >> $gitPath/$i.log
                fi
                done
            else
                echo "$i is a directory"
            fi
        done
    fi
elif [[ $comand == "check" ]]
then
        for i in $(ls $pathToDir)
        do
            if [[ -f $gitPath/$i ]]
            then
                lastFile=$(ls $gitPath | awk -v file=$i -F '.' '$1 ~ file' | sort -t '.' -nk 2 | tail -1)
                sizeInDir=$(stat -f%z $gitPath/lastFile)
                sizeInGit=$(stat -f%z ~/OC/dopTaskDir/$i)
                if [[ $sizeInDir != $sizeInGit ]]
                then
                    rm $gitPath/$lastFile
                    buffer=$(cat $gitPath/$i.log)
                    id=$(cat $gitPath/$i.log | head -1)
                    id="$(($id + 1))"
                    
                    grep -Fxvf $gitPath/lastFile ~/OC/dopTaskDir/$i > $gitPath/$i.log
                    
                    counter=0
                    echo $buffer | while read line; do
                    counter=$(($counter + 1))
                    if [[ $counter == 1 ]]
                    then
                        echo $id > $gitPath/$i.log
                    else
                        echo $line >> $gitPath/$i.log
                    fi
                    done
                    cp ~/OC/dopTaskDir/$i $gitPath/$i.$id
                else
                    echo "no changes"
                fi
            else
                echo "don't exist"
            fi
        done
else
    echo "unknown comand: $comand"
    kill -9 $$
fi

