#!/bin/bash

while true; do

mkfifo server.pipe

read -a input_array

case ${input_array[0]} in
    create_database)
        input_to_script=${input_array[@]:3}
        ./create_database.sh $input_to_script &
        ;;
    create_table)
        input_to_script=${input_array[@]:3}
        ./create_table.sh $input_to_script &
        ;;
    insert)
        input_to_script=${input_array[@]:3}
        ./insert.sh $input_to_script &
        ;;
    select)
        input_to_script=${input_array[@]:3}
        ./select.sh $input_to_script &
        ;;
    shutdown)
        rm server.pipe
    *)
        exit 0
        
        echo "Error: bad request"
        exit 1
    esac
done