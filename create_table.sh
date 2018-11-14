#!/bin/bash
  
databasedir="database/"
database="$1"
table="$2"
columns="$3"

if [ "$#" -ne 3 ]; then
        echo "Error: the number of parameters must be 3" >&2
	exit 1

elif [ ! -d "$databasedir$database" ]; then
        echo "Error: DB does not exist" >&2
	exit 2

elif [ -e "$databasedir$database/$table" ]; then
	echo "Error: Table already exists" >&2
	exit 2

else
	echo "$columns" > "$databasedir$database/$table" 
	echo "OK. Table created">&2
	exit 0


fi
