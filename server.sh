#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
    echo "Server has been shut down"
    rm server.pipe
    exit 0
}	

mkfifo server.pipe

while true; do
    	read -a input_array
    	id=${input_array[1]}
    	input=(${input_array[@]:0:1} ${input_array[@]:2})   
    	case ${input[0]} in
    		create_database)
        		input_to_script=${input[@]:1}
                	echo "Creating database"
                	./create_database.sh $input_to_script > $id.pipe & 
                	;;
        	create_table)
                	input_to_script=${input[@]:1}
                	echo "Creating table"
                	./create_table.sh $input_to_script > $id.pipe &
                	;;
        	insert)
                	input_to_script=${input[@]:1}
                	echo "Inserting row"
                	./insert.sh $input_to_script > $id.pipe &
                	;;
        	select)
                	input_to_script=${input[@]:1}
               		echo "Selecting columns"
                	result=$(./select.sh $input_to_script) 
			echo $result > $id.pipe &
                	;;
        	shutdown)
                	echo "OK. Server has been shut down" > $id.pipe &
                	echo "Server has been shutdown"
			rm server.pipe
                	exit 0
                	;;
    	esac
done < server.pipe
