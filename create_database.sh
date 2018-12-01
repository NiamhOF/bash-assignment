#!/bin/bash

databasedir="database/"
database="$databasedir$1"


if [ "$#" -eq 0 ]; then
	echo "Error: no parameter"
	exit 1

elif [ "$#" -gt 1 ]; then
	echo "Error: Too many parameters" 
	exit 1

else
	./P.sh "$database"
	if [ -d "$database" ]; then
		echo "Error: DB already exists"
		./V.sh "$database"
		exit 2
	else
		mkdir "$database"
		echo "OK: database created" 
		./V.sh "$database"
		exit 0		
	fi
	
fi

