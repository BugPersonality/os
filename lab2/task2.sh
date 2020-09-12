#!/bin/bash

ps -aux | awk '$11 ~ "/sbin/.*" {print "PID = " $2 " command = " $11}' >  answ2.lst
