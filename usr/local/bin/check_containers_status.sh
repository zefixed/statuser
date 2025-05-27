#!/bin/bash

CONTAINERS=("containers")

message=""
for container in "${CONTAINERS[@]}"
do
    container_status=$(docker ps -a --filter "name=^$container\$" --format "{{.Status}}")
    if echo "$container_status" | grep -i "up" >/dev/null 2>&1; then
	message+="🟢 $container    $container_status\n"
    else
	message+="🔴 $container    $container_status\n"
    fi
done

if (( ${#message} != 0)); then
    echo -e "${message::-2}"
fi
