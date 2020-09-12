#!/bin/bash 

grep "\\(WW\\)" //var/log/anaconda/X.log | sed -E "s/\\(WW\\)/ WARNING: /" > full.log
grep "\\(II\\)" //var/log/anaconda/X.log | sed -E "s/\\(II\\)/ INFORMATION: /" >> full.log

