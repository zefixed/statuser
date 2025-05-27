#!/bin/bash

ADDRESSES=("addresses")

message=""
for address in "${ADDRESSES[@]}"
do
    http_status=$(curl -s -o /dev/null -w "%{http_code}" -L $address)
    if echo "$http_status" | grep "200" >/dev/null 2>&1; then
	message+="🟢 $http_status $address\n"
    else
	message+="🔴 $http_status $address\n"
    fi
done

if (( ${#message} != 0)); then
    echo -e "${message::-2}"
fi
