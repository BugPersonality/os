#!/bin/bash

man $1 > testf.lst | sed "/.+OPTIONS/d"
