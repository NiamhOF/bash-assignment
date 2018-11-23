#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
    rm server.pipe
    exit 0
}

mkfifo server.pipe
recieved=""

while true; do
    # Why is line 14 giving me an interrupted system call??
    read -a input_array < server.pipe
    check=${input_array[*]}
    if [ "$received" != "$check" ]; then
        id=${input_array[1]}
        input=(${input_array[@]:0:1} ${input_array[@]:2})   
        # echo  $id > $id.pipe # This echoes back to client!
        # echo ${input[*]}
        # echo ${input[@]:1} > $id.pipe
        # echo $id.pipe
        # ./create_database.sh ${input[@]:1} > $id.pipe &
        
        case ${input[0]} in
            create_database)
                input_to_script=${input[@]:1}
                # Printing to server and not into pipe
                ./create_database.sh $input_to_script > $id.pipe & 
                ;;
            create_table)
                input_to_script=${input[@]:1}
                ./create_table.sh $input_to_script > $id.pipe &
                ;;
            insert)
                input_to_script=${input[@]:1}
                ./insert.sh $input_to_script > $id.pipe &
                ;;
            select)
                input_to_script=${input[@]:1}
                ./select.sh $input_to_script > $id.pipe &
                ;;
            shutdown)
            # Should user be allowed to shut down server pipe?
                rm server.pipe
                exit 0
                ;;
            *)
                
                echo "Error: bad request" > $id.pipe
                
            esac
            received=$check

    fi
done