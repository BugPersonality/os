#!/bin/bash

awk 'BEGIN {i = 0 ; now_ppid = 0; now_art = 0.0; count = 0;}
{
	if (i == 0)
	{
		count=1.0
		now_ppid=$7
		now_art+=$11
	}
	else if (now_ppid != $7)
	{
		print "Average_Sleeping_Children_of_Parent = " now_ppid " is " now_art
		now_art=$11
		now_ppid=$7
	}
	else
	{
		count++
		now_art+=$11
	}
	print $0
	i++
}' answ4_1.lst > answ5.lst

