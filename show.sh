MESSAGE_FILE=$1

COMMIT_MESSAGE=$(cat $MESSAGE_FILE | grep -v "^#")

echo "$COMMIT_MESSAGE" "[merged from trunk]" > $MESSAGE_FILE
