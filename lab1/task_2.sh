#!/bin/bash
let string
let answer

while [[ "${string}" != "q" ]]
do
answer+=$string
read string

done
echo $answer
