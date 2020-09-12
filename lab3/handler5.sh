#!/bin/bash
MODE="+"
X=1
mode_state()
{
	echo "Change mode from $MODE to $1"
	if [[ $1 == "*" ]]
	then	MODE="*"
	elif [[ $1 == "+" ]]
	then 	MODE="+"
	fi
}
(tail -f pipe5) |
while true;
do
	read line
	if [[ $line == [[:digit:]]* ]]
	then
		if [[ "$MODE" == "+" ]]
		then 	echo "$X + $line = "
			X=$(echo ${X}" + "${line} | bc)
			echo "$X"
		elif [[ "$MODE" == "*" ]]
		then 	echo "$X * $line = "
			X=$(echo ${X}" * "${line} | bc)
			echo "$X"
		fi
	elif [[ ($line == "+") || ($line == "*") ]]
	then	mode_state "$line"
	elif [[ $line == "stop" ]]
	then kill -9 $$
	fi
done
