#!/bin/sh

killtree() {
    local _pid=$1
    local _sig=${2-TERM}

    for _child in $(pgrep -P ${_pid}); do
#	echo "call killtree $_child"
        killtree $_child $_sig
    done
    kill -${_sig} $_pid
#   echo "kill $_pid"

	var=`ls /proc/$_pid 2>/dev/null`
	if [ -n "$var" ]; then
#    	echo "waiting for $1"
		sleep 1 
	fi
	
}

if [ $# -eq 0 -o $# -gt 2 ]; then
    echo "Usage: $(basename $0) <pid> [signal]"
    exit 1
fi

killtree $@
