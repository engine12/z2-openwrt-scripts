#!/bin/sh

trap 'rm /tmp/vt/$1; rm /tmp/apps/$1 2>/dev/null' TERM INT

vt=`fgconsole`
echo $vt >/tmp/vt/$1
$2
$3

rm /tmp/apps/$1 2>/dev/null
rm /tmp/vt/$1 2>/dev/null

#if there is a final argument then return 
#to gmenu2x after the app is closed
#Note: this will close an app that was started by gmenu2x
#		but not placed into a new vt (i.e. the 'old way')
# Example:  links and nano are both running...
#links was started with this script and was thus started 
#on it's own terminal with gmenu2x still running
#Nano was then started from gmenu2x, but was launched 
#the 'old way' and thus replaces the gmenu2x 
#process (gmenu2x is no longer running)
#if the user now switches to Links and closes it, 
#the onHome handler will be called
#this will lead to nano being closed (changes will not saved...  
#you will not be prompted to do so) and then gmenu2x starting
if [ -n "$4" ]; then
    onHome
fi

