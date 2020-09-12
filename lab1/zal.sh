#!/bin/bash

man $1 | grep -o -i "\-[a-z] .*" | awk '{print $1, " : ", $2, $3}'
