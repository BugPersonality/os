#!/bin/bash

echo  "1: Launch nano"
echo  "2: Launch vi"
echo  "3: Launch links"
echo  "4: exit"

read num

if [[ $num -eq 1 ]]
	then nano
fi
if [[ $num -eq 2 ]]
	then vi
fi
if [[ $num -eq 3 ]]
	then links google.com
fi
if [[ $num -eq 4 ]] 
	then exit
fi
