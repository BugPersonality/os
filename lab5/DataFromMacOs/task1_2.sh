#!/bin/bash
./mem_script &
./mem_script1 &
rm -r $1 2> /dev/null > /dev/null
mkdir $1 2> /dev/null > /dev/null
pid1=0
pid2=0
while true
do
    check=$(pidof mem_script)

    if [[ $check != "" ]]
    then
        pid1=$check
    fi

    check=$(pidof mem_script1)

    if [[ $check != "" ]]
    then
            pid2=$check
        fi

    if [[ $(pidof mem_script) == $(pidof mem_script1) ]]
    then
        cat report.log | tail -1 >> $1/count
        cat report1.log | tail -1 >> $1/count
        dmesg | grep "mem_script" | grep $pid1 >> $1/dmesg
        dmesg | grep "mem_script1" | grep $pid2 >> $1/dmesg
        break
    fi
    (top | head -10 | grep PhysMem | awk '{print $2}') | tr ',' '.' | tr 'M' ' ' >> $1"/topTotal.txt"
    (top | head -10 | grep PhysMem | awk '{print $6}') | tr ',' '.' | tr 'M' ' ' >> $1"/topUsed.txt"
    (sysctl -a | grep swap | head -1 | awk '{print $4}') | tr ',' '.' | tr 'M' ' ' >> $1"/swapTotal.txt"
    (sysctl -a | grep swap | head -1 | awk '{print $7}') | tr ',' '.' | tr 'M' ' ' >> $1"/swapUsed.txt"
done
