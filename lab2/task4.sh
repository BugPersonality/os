#!/bin/bash

echo > answ4.lst

for i in $(ls /proc | grep "[0-9]")
do

(awk '{
	if ($1 == "PPid:")
	{
        	printf "ParentProcessId = %d", $2
	}
	if ($1 == "Pid:")
	{
	        printf "ProcessID = %d : ", $2
	}
       }' /proc/$i/status >> answ4.lst) 2> /dev/null

(awk '{
	if ($1 == "se.sum_exec_runtime")
	{
           sum_exec_runtime=$3
	}
	if ($1 == "nr_switches")
	{
	   nr_switches=$3
	   print " : Average_runing_time = " sum_exec_runtime/nr_switches
	}
     }' /proc/$i/sched >>  answ4.lst) 2> /dev/null
done

sort -n -k 7 answ4.lst > answ4_1.lst
rm answ4.lst

