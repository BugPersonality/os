#!/bin/bash

case $1 in
*\ *)
echo "incorrect parameters with gaps"
kill -9 $$
;;
esac

if (( $# != 1 ))
then
    echo "parameters error!"
    kill -9 $$
fi

if [[ ! -d ~/OC/.trash ]]
    then mkdir ~/OC/.trash
fi

echo $1

fileName=$(date +%s%N)

if [[ ! -e $1 ]]
then
    echo "file doesn't exist"
    kill -9 $$
fi

ln $1 ~/OC/.trash/$fileName
rm -R $1

if [[ ! -e ~/OC/trash.log ]]
    then touch ~/OC/.trash.log
fi

echo "$PWD/$1 $fileName" >> ~/OC/.trash.log
