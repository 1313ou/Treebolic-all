#!/bin/bash

R='\u001b[31m'
G='\u001b[32m'
Y='\u001b[33m'
B='\u001b[34m'
M='\u001b[35m'
C='\u001b[36m'
Z='\u001b[0m'

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
DIR=dist/releases

declare -A PACKAGES
PACKAGES=(
[treebolicWordNet]=org.treebolic.wordnet.browser
#[treebolicWordNetForAmazon]= org.treebolic.wordnet.browser.amazon
[treebolicWordNetForGoogle]=org.treebolic.wordnet.browser.google
[treebolicWordNetIAB]=org.treebolic.wordnet.browser.iab
)

declare -A FLAVORS
FLAVORS=(
[treebolicWordNet]= 
[treebolicWordNetForAmazon]= 
[treebolicWordNetForGoogle]=
[treebolicWordNetIAB]=-production
)

AABS="${!PACKAGES[@]}"

for aab in ${AABS}; do
	package=${PACKAGES[${aab}]}
	flavor=${FLAVORS[${aab}]}
	file=${DIR}/${aab}${flavor}-release.aab
	if [ ! -e "${file}" ]; then
		echo -e "${B}${aab}${Y}${flavor} ${M}${package} ${R}${file}${Z}"
	else
		echo -e "${B}${aab}${Y}${flavor} ${M}${package} ${C}${file}${Z}"
	fi
	python2 googleplay_upload_aab.py \
		${package} \
		"${RELEASE_NAME}" \
		"${RECENT_CHANGES}" \
		${file}
done
