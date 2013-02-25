#!/bin/sh
#start at the end of the playlist  -->   sed '1!G;h;$!d'
clear

url=$(plsToURL $1)
#echo $url

if [ $? -eq 1 ]; then	
	chvt `cat /tmp/vt/links`
	exit 1
fi

killall -9 catMP3 >/dev/null
stopApp `pidof wgetMP3`

openvt streamMP3
openvt -s wgetMP3 $url

sleep 3
chvt `cat /tmp/vt/links`


