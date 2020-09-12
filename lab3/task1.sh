#!/bin/bash

mkdir /home/test &&
{
 echo "catalog test was created \n" >> ~/report 
 touch /home/test/$(date +%H:%M_%d_%m_%Y)
}

ping -w 1 "www.net_nikogo.ru" || echo $(date +%d_%m_%Y_%H_%M) ping error >> ~/report
