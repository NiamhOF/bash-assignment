#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
    rm $id.pipe
    exit 0
}

read -p 'Enter ID: ' id
idcheck=$(echo $id | wc -w)

if [ "$idcheck" -ne 1 ]; then
    echo "Error: parameter problem" >&2
	exit 1

elif [ -p $id.pipe ]; then
    echo "Error. That ID already exists" >&2
    exit 2

else 
    mkfifo $id.pipe
    while true; do
        read -p 'Enter command: ' req
        echo $req



    done
fi