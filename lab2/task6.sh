#!/bin/bash

max_mem=0
pid=0

for i in $(ls /proc | grep "[0-9]")
do
	temp_mem=$(awk '$1 == "VmSize:" {print $2}' /proc/$i/status)
	temp_pid=$(awk '$1 == "Pid:" {print $2}' /proc/$i/status)

	if [[ "$max_mem" -lt "$temp_mem" ]];
	then max_mem=$temp_mem pid=$temp_pid
	fi
done

echo "pid = $pid max_mem = $max_mem"

top -o VIRT | head -8 | tail -1 | awk '{print "pid = " $2 " max_mem by top = " $6}'
