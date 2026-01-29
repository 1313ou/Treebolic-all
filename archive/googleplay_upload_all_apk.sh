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

./googleplay_upload_treebolic.sh				    "${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_dot.sh				"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_owl.sh				"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_files.sh				"${RELEASE_NAME}" "${RECENT_CHANGES}"

./googleplay_upload_treebolic_wordnet.sh			"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_wordnet_lockable.sh	"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_wordnet_google.sh		"${RELEASE_NAME}" "${RECENT_CHANGES}"

./googleplay_upload_treebolic_contacts.sh			"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_royals.sh				"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_royals_iab.sh			"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_fungi.sh				"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_sumo.sh				"${RELEASE_NAME}" "${RECENT_CHANGES}"
./googleplay_upload_treebolic_owl_sumo.sh			"${RELEASE_NAME}" "${RECENT_CHANGES}"

