#!/bin/sh
app=nano
#  this script allows only one instance 
#  of nano to be started by gmenu2x

clear
pid=`cat /tmp/apps/$app` 2>/dev/null

if [ ! $pid ]; then

	rm /tmp/vt/gmenu2x 2>/dev/null
	openvt -s launch $app 'echo' 'nano' 1

else
	chvt `cat /tmp/vt/$app`
fi

