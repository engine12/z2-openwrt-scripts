#!/bin/sh

mpg123_pid=`cat /tmp/apps/mpg123` 2>/dev/null
if [ ! $mpg123_pid ]; then 

	killall mpg123 2>/dev/null
	killall mplayer 2>/dev/null
	#killall movgrab

	pidof mpg123
	mpg123_stat=$?

	#wait for mpg123 to die, it removes /tmp/vt/mpg123
	#so wait for it to do so before creating a new one
	while [ $mpg123_stat -eq 0 ]
	do	
		sleep 1
		pidof mpg123
		mpg123_stat=$?
	done

	deallocvt
	openvt -s launch.d mpg123 "echo" 'mpg123 --timeout 0 --long-tag --remote --fifo /tmp/mpg123' >/dev/tty2
	#url=`cat ${1} | grep -e 'File1' | head -n 1 | cut -f 2 -d =`

	mpg123_stat="1"
	while [ $mpg123_stat -ne 0 ]
	do	
		sleep 1
		pidof mpg123
		mpg123_stat=$?
	done

	echo `pidof mpg123`>/tmp/apps/mpg123
else
	exit 1
fi




