#!/bin/sh
clear

if [ "$(pidof streamripper)" ]; then
	echo;echo;echo
	echo "Streamripper is already active."
	echo "it can be closed with Ctrl+C"

	sleep 3

	chvt `cat /tmp/vt/strRip`
	exit
fi

echo "Preparing Streamripper...."

url=$(plsToURL $1)

if [ $? -eq 1 ]; then	
#	sleep 3
	chvt `cat /tmp/vt/links`
	exit 1
fi



localHost=localhost:8093
music_dir=/mnt/mmcblk0p1/music
#theRipper=$music_dir/streamripper
theRipper=streamripper

if [ ! -d "$music_dir" ]; then
	echo "Directory $music_dir does not exist!"
	exit
fi

killall mpg123 2>/dev/null
killall mplayer 2>/dev/null
killall movgrab 2>/dev/null
#killall streamripper

#don't really need to terminate wgetMP3 but 
#by default we will so that it's not hanging 
#around in the background unsuspectingly
killall wgetMP3 2>/dev/null

deallocvt
#start mpg123 in the background so that we can play/pause it with the ZipIt play btn
openvt -s launch.d mpg123 "mpg123 --timeout 0 --keep-open --remote --fifo /tmp/mpg123"

# -T instructs to truncate 'complete' files in the 'incomplete' dir to be zero bytes
# -R is the number of clients that are allowed to connect on the remote interface
# -M is the maximun number of MegaBytes to allow for new mp3 files
openvt -s launch.d strRip  "$theRipper $url -T -d $music_dir -u mpg123 -r $localHost -R 1 -M 100"

sleep 2

mpg123_stat="1"
while [ $mpg123_stat -ne 0 ]
do	
	sleep 1
	pidof mpg123
	mpg123_stat=$?
done

echo `pidof mpg123`>/tmp/apps/mpg123
echo `pidof streamripper`>/tmp/apps/strRip

#send the url to mpg123
echo "load http://${localHost}" >/tmp/mpg123
#echo "eqfile /usr/share/eq" >/tmp/mpg123
echo "seq 1.3 1.4 1.7" >/tmp/mpg123
echo "silence" >/tmp/mpg123


chvt `cat /tmp/vt/strRip`

