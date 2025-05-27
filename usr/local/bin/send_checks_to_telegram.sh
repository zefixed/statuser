#!/bin/bash

CHECKS=("check_containers_status.sh" "check_http_status.sh")

message="<blockquote>\n"
for check in "${CHECKS[@]}"
do
	message+=$(/usr/local/bin/"$check")
	message+="\n"
done
message+="</blockquote>"

if echo -e "$message" | grep "🔴" >/dev/null 2>&1; then
	/usr/local/bin/notify_telegram.sh "$message"
fi
