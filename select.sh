#!/bin/bash
  
databasedir="database/"
database="$1"
table="$2"
column="$3"
columnnew=$(echo "$column" | sed 's/,/ /g')
columnnum=$(head -n 1 "$databasedir$database/$table" | sed 's/,/ /g' | wc -w)

function checkColumnsAreValid() {
	columns_space=$1
	num_table_columns=$2
	result=1
	for column in $columns_space; do
		if (( $column <= 0 || $column > $num_table_columns )); then
			result=0
		fi
	done
echo $result	
}

if [ "$#" -gt 3 ]; then
        echo "Error: parameter problem" >&2
	exit 1

elif [ ! -d "$databasedir$database" ]; then
        echo "Error: DB does not exist" >&2
	exit 2

elif [ ! -e "$databasedir$database/$table" ]; then
        echo "Error: Table does not exist" >&2
	exit 2

elif [ $(checkColumnsAreValid "$columnnew" "$columnnum") -eq 0 ]; then
	echo "Error: column does not exist"
	exit 2

fi
