#!/bin/bash

nice -n 10 ./task4.sh&
nice -n 0 ./task4.sh&
nice -n 19 ./task4.sh&
