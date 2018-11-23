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
        read -p 'Enter command: ' input
        # -- means stdin, which splits the input into arguments automatically
        set -- $input
        echo "$#"
        request="$1"
        if [[ "$request" == 'create_database' ]] || 
        [[ "$request" == 'create_table' ]] || 
        [[ "$request" == 'select' ]] || 
        [[ "$request" == 'insert' ]]; then

            shift 1
            serverRequest="$request $id $@"
            echo "$serverRequest"
            echo "$serverRequest" > server.pipe
            read pipe_input < $id.pipe
            echo $pipe_input
            case $pipe_input in
                Error:*)
                    echo $pipe_input
                    ;;
                OK*)
                    echo $pipe_input
                    ;;
                start_result)
                    while [ "$pipe_input" != "end_result" ]; do
                        read pipe_input < $id.pipe
                        echo $pipe_input
                        done
                    ;;
            *) 
                echo "Unexpected error"
            esac
        else
            echo "A command must begin with create_database, create_table, insert or select"
        fi



    done
fi