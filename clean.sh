rm *.pipe
rm database/*lock
rm database/*/*lock
ps -ef | grep server.sh | grep -v grep | awk '{print $2}' | xargs kill
ps -ef | grep client.sh | grep -v grep | awk '{print $2}' | xargs kill
