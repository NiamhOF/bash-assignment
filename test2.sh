#!/bin/bash 
sleep 1
echo -e -n "create_database test_db\ncreate_table test_db test_table c1,c2,c3\ninsert test_db test_table v2,v2,v2\nselect test_db test_table 2,3\nexit" | ./client.sh admin2 > clientout2 &
