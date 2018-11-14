#!/bin/bash

databasedir="database/"

if [ "$#" -eq 0 ]; then
	echo "Error: no parameter" >&2
	exit 1

elif [ "$#" -gt 1 ]; then
	echo "Error: Too many parameters" >&2
	exit 1

elif [ -d "$databasedir$1" ]; then
	echo "Error: DB already exists" >&2
	exit 2

else
	mkdir "$databasedir$1"
	echo "OK: database created" >&2
	exit 0

fi
