#!/bin/bash

RELEASE_NAME="$1"
if [ -z "${RELEASE_NAME}" ]; then
	V=`./find-version.sh`
	RELEASE_NAME="I${V}"
	echo "Version name ${RELEASE_NAME}"
fi
RECENT_CHANGES="$2"
if [ -z "${RECENT_CHANGES}" ]; then
	RECENT_CHANGES="Fixes"
fi
PACKAGE=org.treebolic.owl.sumo
AAB=treebolicSumo
DIR=dist/releases

python2 googleplay_upload_aab.py \
	${PACKAGE} \
	"${RELEASE_NAME}" \
	"${RECENT_CHANGES}" \
	--draft
	${DIR}/${AAB}-release.aab \

