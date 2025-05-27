#!/bin/bash

BOT_TOKEN="bottoken"
CHAT_IDs=("chatids")
MESSAGE="$1"

MESSAGE=$(echo -e "$MESSAGE")

for chat_id in "${CHAT_IDs[@]}"
do
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d "chat_id=$chat_id" \
     -d "text=$MESSAGE" \
     -d "parse_mode=HTML"
done
