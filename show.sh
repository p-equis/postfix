MESSAGE_FILE=$1

echo "Message file: " $MESSAGE_FILE


COMMIT_MESSAGE=echo "merged from trunk" | cat $MESSAGE_FILE - 

echo $COMMIT_MESSAGE > $MESSAGE_FILE
