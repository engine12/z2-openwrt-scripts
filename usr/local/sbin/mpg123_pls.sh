#!/bin/sh
#start at the end of the playlist  -->   sed '1!G;h;$!d'
clear

url=$(plsToURL $1)
#echo $url

if [ $? -eq 1 ]; then	
	chvt `cat /tmp/vt/links`
	exit 1
fi


killall mpg123 2>/dev/null
killall mplayer 2>/dev/null
#killall movgrab

#don't really need to terminate wgetMP3 but 
#by default we will so that it's not hanging 
#around in the background unsuspectingly
killall wgetMP3 2>/dev/null

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
openvt -s launch.d mpg123 "echo Preparing to play $url" 'mpg123 --timeout 0 --keep-open --long-tag --remote --fifo /tmp/mpg123'
#url=`cat ${1} | grep -e 'File1' | head -n 1 | cut -f 2 -d =`

mpg123_stat="1"
while [ $mpg123_stat -ne 0 ]
do	
	sleep 1
	pidof mpg123
	mpg123_stat=$?
done

echo `pidof mpg123`>/tmp/apps/mpg123

#send the url to mpg123
echo "load ${url}" >/tmp/mpg123
#echo "eqfile /usr/share/eq" >/tmp/mpg123
echo "seq 1.3 1.4 1.7" >/tmp/mpg123
echo "silence" >/tmp/mpg123


sleep 3
chvt `cat /tmp/vt/links`


