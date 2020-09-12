#!/bin/bash

while true; do

	read line
	#echo $line > pipe5

	if [[ ($line == [[:digit:]]*) || ($line == "+") ]]
	then	echo $line > pipe5
	elif [[ $line == "*" ]]
	then 	echo "*" > pipe5
	elif [[ $line == "stop" ]]
	then
		echo "stop" > pipe5
		kill -9 $$
	elif [[ ($line != [[:digit:]]*) && ($line != "+") && ($line != "*") ]]
	then
		echo "stop" > pipe5
		kill -9 $$
	fi

done
