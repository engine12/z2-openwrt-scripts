#!/bin/sh
clear

rip_pid=`pidof streamripper`

if [ -z "$rip_pid" ]; then
	echo "Streamripper isn't running."
	echo "Open Links and select a stream from shoutcast.com."
	read -n 1 -p "....press any key to continue"	
	onHome
else
	chvt `cat /tmp/vt/strRip`
fi

