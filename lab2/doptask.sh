#!/bin/bash

ps -eo pid,etimes,s | awk '{if ($2 <= 60 && $3 == "S") print "pid = " $1 " time = " $2 " S = " $3}'
