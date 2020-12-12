#!/bin/bash

touch report.log

count_step=0
array_index=0
array=()

while true
do
    for (( count=0; count<10; count++ ))
    do
        array[$array_index]=$count
        array_index=$((array_index+1))
    done

    count_step=$((count_step+1))
    check=$(echo $count_step"%100000" | bc)

    if [[ $check == "0" ]]
    then
        echo "${#array[*]}" >> report.log
    fi
done


