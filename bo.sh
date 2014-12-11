#!/bin/bash

LOGGING=true # This will print the message and response to the syslog. 
URL="https://api.pushover.net/1/messages.json"

APP_KEY="" #token
USER_KEY="" #user

TITLE="Alert"
PRIORITY=1


MESSAGE=$*


if [ ${#APP_KEY} == 0 ]
then
	echo "Error: You need to supply an app token"
	exit 1;
fi

if [ ${#USER_KEY} == 0 ]
then
	echo "Error: You need to supply a user key"
	exit 1;
fi

if [ ${#MESSAGE} == 0 ]
then
	MESSAGE=$(cat)
fi

RESPONSE=`curl -s --data token=$APP_KEY --data user=$USER_KEY --data-urlencode title="$TITLE" --data priority=$PRIORITY --data-urlencode message="$MESSAGE" $URL`


if [ $LOGGING == true ]
then
	logger "PUSH"
	logger "|"
	logger "| MESSAGE: $MESSAGE"
	logger "| RESPONSE: $RESPONSE"
	logger "|___________________________________________________________________________________________"
fi
