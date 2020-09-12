#1/bin/bash 

SECONDS=0

rm buff_proc*

for i in $(ls /proc | grep "[0-9]")
do
	awk '$1 == "rchar:" {printf "%d ", $2}' /proc/$i/io >> buff_proc_1.txt
	cmd=$(ps -eo pid,cmd | awk -v id=$i '$1 == id {print $2}')
	echo $1 $cmd >> buff_proc_1.txt
done

sleep 5

for i in $(ls /proc | grep "[0-9]")
do
	awk '$1 == "rchar:" {printf "%d ", $2}' /proc/$i/io >> buff_proc_2.txt
	echo $i >> buff_proc_2.txt
done

while read line
do
	pid=$(echo $line | awk '{print $2}')
	mem=$(echo $line | awk '{print $1}')

	awk -v p=$pid -v m=$mem '{
				if ($2 == p)
				{
					printf "PID : %d Delta %d", $2, m-$1
					print $3
				}
				 }' buff_proc_1.txt >> answ7.txt
done < buff_proc_2.txt

sort -n -k 5 answ7.txt | tail n -3

rm buff_proc*


