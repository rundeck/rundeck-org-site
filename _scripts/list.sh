#!/bin/bash

IFS=$'\n\t'

make_list() {
    LIST=$(
    while read -r item; do
        DATE=$(echo $item | awk '{print $1}')
        TIME=$(echo $item | awk '{print $2}')
        TIME=$(echo $TIME | cut -d':' -f1,2)
        SIZE=$(echo $item | awk '{print $3}')
        FILE=$(echo $item | awk '{print $4}')

        echo "* [$FILE](https://download.rundeck.org/$i/$FILE) ($SIZE bytes) - $DATE $TIME"
    done <<< "$2")
    echo "${LIST}"
}

write_list() {
    echo "${2}" > ./download/$1/_list.md
    cat ./download/$1/_index.md ./download/$1/_list.md > ./download/$1/index.md
}

for i in deb war jar; do
    S3_LIST="$(make_list $i "$(aws s3 ls s3://download.rundeck.org/$i/ | sort -k 4,4 -V -r)")"
    write_list "${i}" "${S3_LIST}"
done

# RPM
S3_LIST=$(make_list rpm "$(aws s3 ls s3://download.rundeck.org/rpm/ | sort -k 4,4 -V -r | grep -v config)")
S3_LIST+=$(make_list rpm "$(aws s3 ls s3://download.rundeck.org/rpm/ | sort -k 4,4 -V -r | grep config)")
write_list rpm "${S3_LIST}"
