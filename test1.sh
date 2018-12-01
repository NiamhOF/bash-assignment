#!/bin/bash
sleep 1 
echo -e -n "create_database test_db\ncreate_table test_db test_table c1,c2,c3\ninsert test_db test_table v1,v1,v1\nselect test_db test_table 1,2,3\nexit" | ./client.sh admin1 > clientout1 &
