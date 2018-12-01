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
		if [[ "$column"=~^[0-9]+$ ]] && (( $column <= 0 || $column > $num_table_columns )); then
			result=0
		fi
	done
        echo $result	
}

if [ "$#" -gt 5 ]; then
        echo "Error: parameter problem" 
	exit 1

elif [ "$#" -lt 2 ]; then
        echo "Error: parameter problem" 
	exit 1

elif [ ! -d "$databasedir$database" ]; then
        echo "Error: DB does not exist" 
	exit 2

elif [ ! -e "$databasedir$database/$table" ]; then
        echo "Error: Table does not exist" 
	exit 2

elif [ $(checkColumnsAreValid "$columnnew" "$columnnum") -eq 0 ]; then
	echo "Error: column does not exist" 
	exit 2

else
	if [ "$#" -eq 2 ]; then
		print_all=$(cat "$databasedir$database/$table")
		echo "start_result"
		echo "$print_all"
		echo "end_result"
		exit 0

	elif [ "$#" -eq 3 ]; then
		print_all=$(cat "$databasedir$database/$table")
		echo "start_result"
		echo "$print_all" | cut -d , -f"$column"
		echo "end_result"
		exit 0

	elif [ "$#" -eq 4 ] && [[ $3 != *","* ]]; then
		echo "start_result"
		echo $(head -n 1 "$databasedir$database/$table")
                awk -v where=$3 -v value="$4" -F , '$where == value { print }' "$databasedir$database/$table"
		echo "end_result" 
		exit 0

	elif [ "$#" -eq 4 ] && [[ $3 == *","* ]]; then
		echo "Error. Only one column number can be entered to use the where clause"
                exit 1

	else
		whereCheck=$(echo "$4" | sed 's/,/ /g')
		if [ $(checkColumnsAreValid "$whereCheck" "$columnnum") -eq 0 ] ; then
			echo "Error: column does not exist" 
        		exit 2

		elif [[ $4 == *","* ]]; then
			echo "Error. Only one column number can be entered to use the where clause"
			exit 1
	
		else
			echo "start_result"
			echo $(head -n 1 "$databasedir$database/$table") | cut -d , -f"$column"
			awk -v where=$4 -v value="$5" -F , '$where == value { print }' "$databasedir$database/$table" | cut -d , -f"$column"			
			echo "end_result"
		fi
	fi
fi

