#!/bin/sh
COUNT=`/usr/bin/pgrep -O 5 -c -f sidekiq`
if [ $COUNT -eq 0 ]; then
	exit 1
else
	exit 0
fi
