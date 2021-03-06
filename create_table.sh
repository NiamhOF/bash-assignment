#!/bin/bash
  
databasedir="database/"
database="$1"
table="$2"
columns="$3"


if [ "$#" -ne 3 ]; then
        echo "Error: the number of parameters must be 3"
	exit 1

elif [ ! -d "$databasedir$database" ]; then
        echo "Error: DB does not exist"
	exit 2

else
	./P.sh "$databasedir$database"
	if [ -e "$databasedir$database/$table" ]; then
		echo "Error: Table already exists"
		./V.sh "$databasedir$database"
		exit 2

	else
		echo "$columns" > "$databasedir$database/$table" 
		echo "OK. Table created" 
		./V.sh "$databasedir$database"
		exit 0
	fi
fi

