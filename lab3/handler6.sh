#!/bin/bash
echo $$ > .pid
MODE="+"
X=1
usr1()
{
	MODE="+"
}
usr2()
{
	MODE="*"
}
term()
{
	MODE="kill"
}
trap 'usr1' USR1
trap 'usr2' USR2
trap 'term' SIGTERM
while true;
do
	if [[ $MODE == "+" ]]
	then	X=$(echo ${X}" + 2" | bc)
		echo "X + 2 = $X"
	elif [[ "$MODE" == "*" ]]
	then 	X=$(echo ${X}" * 2" | bc)
		echo "X * 2 = $X"
	elif [[ $MODE == "kill" ]]
	then kill -9 $$
	fi
	sleep 2
done



