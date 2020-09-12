#!/bin/bash

ps -eo cmd,s,pid | awk '{if ($1 == "root" && $2 == "S") printf "pid = %d cmd = %d s = %d", $3, $1, $2}'
