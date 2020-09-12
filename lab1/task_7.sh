#!/bin/bash

grep -E -s -h -o "[[:alnum:]_]+@[[:alnum:]_]+(\\.[a-z]+)+" //etc/* | tr "\n" ", " > emails.lst 
