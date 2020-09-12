#!/bin/bash

man $1 | grep -i -o "-[a-z]" | sort | uniq -c | awk '{print $2}'
