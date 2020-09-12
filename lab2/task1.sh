#!/bin/bash 

ps -aux | awk '$1 = "user"'| wc -l > task_1.lst
ps -aux | awk '$1 = "user" {print $2 ":" $11}' >> task_1.lst

