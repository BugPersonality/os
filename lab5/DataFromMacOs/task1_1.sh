#!/bin/bash
./mem_script &
rm -r $1 2> /dev/null > /dev/null
mkdir $1 2> /dev/null > /dev/null
pid=0

while true
do
    check=$(pidof mem_script)
    if [[ $check == "" ]]
    then
        dmesg | grep "mem_script" | grep $pid > $1/dmesg
        cat report.log | tail -1 > $1/count
        break
    else
        pid=$check
    fi
    (top | head -10 | grep PhysMem | awk '{print $2}') | tr ',' '.' | tr 'M' ' ' >> $1"/topTotal.txt"
    (top | head -10 | grep PhysMem | awk '{print $6}') | tr ',' '.' | tr 'M' ' ' >> $1"/topUsed.txt"
    (sysctl -a | grep swap | head -1 | awk '{print $4}') | tr ',' '.' | tr 'M' ' ' >> $1"/swapTotal.txt"
    (sysctl -a | grep swap | head -1 | awk '{print $7}') | tr ',' '.' | tr 'M' ' ' >> $1"/swapUsed.txt"
done
