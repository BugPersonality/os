#!/bin/bash

pid1=$1
pid2=$2
pid3=$3
limit1=$4
limit2=$5
limit3=$6

while true
do
    if [[ $mem1 != "" ]]
    then
        check=$(echo $(ps -o vsz -p $pid1 | tail -1)"/"$mem1 | bc)
        echo $pid1 $check

        if [[ "$check" -gt "2" ]]
        then
            echo "warning: pid- $pid1 is using a lot of memory"
        fi
    fi
    if [[ $mem2 != "" ]]
    then
        check=$(echo $(ps -o vsz -p $pid1 | tail -1)"/"$mem2 | bc)
        echo $pid2 $check

        if [[ "$check" -gt "2" ]]
        then
            echo "warning: pid- $pid2 is using a lot of memory"
        fi
    fi
    if [[ $mem3 != "" ]]
    then
        check=$(echo $(ps -o vsz -p $pid1 | tail -1)"/"$mem3 | bc)
        echo $pid3 $check

        if [[ "$check" -gt "2" ]]
        then
            echo "warning: pid- $pid3 is using a lot of memory"
        fi
    fi

    if [[ $pid1 != "" ]]
    then
        mem1=$(ps -o vsz -p $pid1 | tail -1)
    else
        mem1=""
    fi
    
    if [[ $pid2 != "" ]]
    then
        mem2=$(ps -o vsz -p $pid2 | tail -1)
    else
        mem2=""
    fi
    
    if [[ $pid3 != "" ]]
    then
        mem3=$(ps -o vsz -p $pid3 | tail -1)
    else
        mem3=""
    fi
    
    echo "$mem1 $mem2 $mem3"

    if [[ "$mem1" -gt "$limit1" ]]
    then
        echo "kill $pid1"
        kill -9 $pid1
        pid1=""
    fi

    if [[ "$mem2" -gt "$limit2" ]]
    then
        echo "kill $pid2"
        kill -9 $pid2
        pid2=""
    fi

    if [[ "$mem3" -gt "$limit3" ]]
    then
        echo "kill $pid3"
        kill -9 $pid3
        pid3=""
    fi

    sleep 1
done
