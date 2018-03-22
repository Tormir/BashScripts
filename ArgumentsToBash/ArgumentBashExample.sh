#!/bin/bash
if [ -z "$1" ]; then
	echo "Give argument, e.g. sh test.sh 1"
	exit
fi
if [ ! -z "$2" ]; then
	echo "Don't give more arguments than one"
	exit
fi
abc=$1
while :
do 
	echo $abc
	sleep 1
	abc=$(($abc+1))
done
