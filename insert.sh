#!/bin/bash
  
databasedir="database/"
database="$1"
table="$2"
column="$3"
columnnew=$(echo "$column" | sed 's/,/ /g' | wc -w)
columnnum=$(head -n 1 "$databasedir$database/$table" | sed 's/,/ /g' | wc -w)

if [ "$#" -gt 3 ]; then
        echo "Error: parameter problem" >&2
	exit 1

elif [ ! -d "$databasedir$database" ]; then
        echo "Error: DB does not exist" >&2
	exit 2

elif [ ! -e "$databasedir$database/$table" ]; then
        echo "Error: Table does not exist" >&2
	exit 2

elif [ "$columnnew" -ne "$columnnum" ]; then
	echo "Error: number of columns in tuple does not match schema" >&2
	exit 1

else
        echo "$column" >> "$databasedir$database/$table"
        echo "OK. Table created" >&2
	exit 0
fi
