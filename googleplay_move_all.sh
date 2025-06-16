#!/bin/bash

VERSION_CODE="$1"
TRACK="$2"
RELEASE_NAME="$3"
RECENT_CHANGES="$4"

if [ "$#" -ne 4 ]; then
	echo "VERSION(number) TRACK[alpha,beta,production] NAME([A|B|R]number) CHANGES"
	exit 1
fi

source define_googleplay_apps.sh

for PACKAGE in ${PACKAGES}; do
	./googleplay_move.sh ${PACKAGE} ${VERSION_CODE} ${TRACK} "${RELEASE_NAME}" "${RECENT_CHANGES}"
	echo
done
