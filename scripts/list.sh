#!/bin/bash

IFS=$'\n\t'

for i in deb rpm war; do
    S3_LIST=$(aws s3 ls s3://download.rundeck.org/$i/ | sort -r)
    LIST=$(
    while read -r item; do
        DATE=$(echo $item | awk '{print $1}')
        TIME=$(echo $item | awk '{print $2}')
        TIME=$(echo $TIME | cut -d':' -f1,2)
        SIZE=$(echo $item | awk '{print $3}')
        FILE=$(echo $item | awk '{print $4}')

        echo "* [$FILE](https://download.rundeck.org/$i/$FILE) ($SIZE bytes) - $DATE $TIME"
    done <<< "$S3_LIST")
    echo "${LIST}" > ./download/$i/_list.md
    cat ./download/$i/_index.md ./download/$i/_list.md > ./download/$i/index.md
done