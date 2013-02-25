#!/bin/sh

killall mpg123
killall mplayer
killall movgrab
deallocvt

format=3gp:400x240

available=`movgrab -st 30 -T -o - $(cat ${1}) 2>&1| grep -e ${format}`

if [ -z "$available" ]; then
	format=3gp:176x144
fi
	
openvt -c 4 `movgrab -st 30 -b -f ${format} -o - $(cat ${1}) | mplayer -mc 10 -cache 1024 -lavdopts fast:skipframe=nonref -autosync 30 - 2>/dev/null`
