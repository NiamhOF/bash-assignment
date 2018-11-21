#!/bin/bash
if [ -z "$1" ]; then
    echo "A parameter must be supplied"
    exit 1
else
    rm "$1-lock"
    exit 0
fi
