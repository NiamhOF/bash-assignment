#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
    echo ""
    echo "Client pipe is being shut down" 
    rm $id.pipe
    exit 0
}

if [ "$#" -ne 1 ]; then
  echo "Error: parameter problem" 
    exit 1

elif [ -p $1.pipe ]; then
  echo "Error. That ID already exists" 
  exit 2

else 
    id=$1
    mkfifo $id.pipe
    echo "A command must begin with create_database, create_table, insert, select, exit or shutdown"
    while true; do
        read -p 'Enter command: ' input
        # -- means stdin, which splits the input into arguments automatically
        set -- $input
        request="$1"
        shift 1
        serverRequest="$request $id $@"
        
        if [[ "$request" == 'exit' ]]; then
            rm -f $id.pipe
            echo "You have exited. Goodbye" 
            exit 0
        fi
        if [[ "$request" != 'create_database' ]] && 
           [[ "$request" != 'create_table' ]] && 
           [[ "$request" != 'select' ]] && 
           [[ "$request" != 'insert' ]] &&
           [[ "$request" != 'shutdown' ]]; then

             echo "A command must begin with create_database, create_table, insert, select, exit or shutdown"
        else
          if [ -p server.pipe ]; then 
                  echo "$serverRequest" > server.pipe
                  while true; do
                
                      read pipe_input
                      case $pipe_input in
                      Error:*)	
                          echo $pipe_input
                          break
                        ;;
                      OK*)
                          echo $pipe_input
                          break
                          ;;
                      start_result*)
                          for line in $pipe_input; do
                            if [[ "$line" != 'start_result' ]] && 
                               [[ "$line" != 'end_result' ]]; then
                                 
                                 echo $line
                            fi
                          done
                          break
                          ;;
                      esac
                  done < $id.pipe
          else 
            echo "Unable to connect to server"
          fi
      fi
    done
fi
