#!/bin/bash

while true;
do

	read line;
	if [[ $line == "+" ]]
	then	kill -USR1 $(cat .pid)
	elif [[ "$line" == "*" ]]
	then	kill -USR2 $(cat .pid)
	elif [[ $line == "term" ]]
	then	kill -SIGTERM $(cat .pid)
		kill -9 $$
	else	echo "error"
	fi

done
