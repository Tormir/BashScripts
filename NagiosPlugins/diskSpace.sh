#!/usr/bin/env bash

t=15

if [ $t -gt 20 ]; then
	echo "error"
	$(exit 2)
elif [ $t -ge 10 -a $t -le 20 ]; then
	echo "warning"
	$(exit 1)
else 
	$(exit 0)
fi
