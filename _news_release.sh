#!/bin/bash
#/ generate news post about new Rundeck release ...
#/ usage: <path/to/rundeck/src> <vers>

set -euo pipefail
IFS=$'\n\t'
readonly ARGS=("$@")
DIR=
VERS=
FILE=
DATE=$(date "+%Y-%m-%d")

usage() {
      grep '^#/' <"$0" | cut -c4- # prints the #/ lines above as usage info
}
die(){
    echo >&2 "$@" ; exit 2
}

make_release_news(){

	local under_vers=${VERS//./_}
	local mm_under_vers=${under_vers%_*}_x
	local mm_dot_vers=${VERS%.*}.x
	
	cat >$FILE <<END
---
layout: news
title: "Rundeck $VERS is now available"
categories:
  - news
comments: true
author: Rundeck Project
published: true
news_rd_version: $VERS
---


[Download Rundeck $VERS now](https://www.rundeck.com/download-page)


A copy of the [release notes](https://docs.rundeck.com/${VERS}/history/${mm_under_vers}/version-${VERS}.html) can be found below:

--------------------

END

	curl -q --fail https://raw.githubusercontent.com/rundeck/docs/${mm_dot_vers}/docs/history/${mm_under_vers}/version-${VERS}.md >> $FILE || die "Unable to download release notes"
	echo "File created: $FILE"
}

check_args(){
	: example to check args length
	if [ ${#ARGS[@]} -lt 1 ] ; then
		usage
		exit 2
	fi
	VERS=${ARGS[0]}

	FILE=$PWD/news/_posts/$DATE-rundeck-$VERS.md
}

# func(){
#    local FARGS=("$@")
#  #    echo $FUNCNAME $@
#  # set -x
#  # do something
#  # set -x
#}
test_file(){
	[ -f $FILE ] && die "File already exists: $FILE" || true
}

main() {
    check_args
    test_file
    # use local vars
    #local i
    make_release_news
}
main

