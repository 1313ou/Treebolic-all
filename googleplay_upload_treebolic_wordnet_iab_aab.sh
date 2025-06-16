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
PACKAGE=org.treebolic.wordnet.browser.iab
AAB=treebolicWordNetIAB-production
DIR=dist/releases

python2 googleplay_upload_aab.py \
	${PACKAGE} \
	"${RELEASE_NAME}" \
	"${RECENT_CHANGES}" \
	${DIR}/${AAB}-release.aab \


