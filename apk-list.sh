#!/bin/bash

source define_colors.sh

RELEASE=build/outputs/apk/release
all="
Treebolic/treebolic/${RELEASE}/treebolic-release.apk
TreebolicPlugins/treebolicDotPlugin/${RELEASE}/treebolicDotPlugin-release.apk
TreebolicPlugins/treebolicFilesPlugin/${RELEASE}/treebolicFilesPlugin-release.apk
TreebolicPlugins/treebolicOwlPlugin/${RELEASE}/treebolicOwlPlugin-release.apk
TreebolicServices/treebolicFilesServices/${RELEASE}/treebolicFilesServices-release.apk
TreebolicServices/treebolicOwlServices/${RELEASE}/treebolicOwlServices-release.apk
TreebolicServices/treebolicWordNetServices/${RELEASE}/treebolicWordNetServices-release.apk

TreebolicWordNet/treebolicWordNetForAmazon/${RELEASE}/treebolicWordNetForAmazon-release.apk
TreebolicWordNet/treebolicWordNetForGoogle/${RELEASE}/treebolicWordNetForGoogle-release.apk
TreebolicWordNet/treebolicWordNetIAB/${PRODUCTION}/treebolicWordNetIAB-production-release.apk
TreebolicWordNet/treebolicWordNet/${RELEASE}/treebolicWordNet-release.apk

TreebolicContacts/treebolicContacts/${RELEASE}/treebolicContacts-release.apk
TreebolicFungi/treebolicFungi/${RELEASE}/treebolicFungi-release.apk
TreebolicPlants/treebolicPlants/${RELEASE}/treebolicPlants-release.apk
TreebolicRoyals/treebolicRoyals/${RELEASE}/treebolicRoyals-release.apk
TreebolicRoyals/treebolicRoyalsIAB/${PRODUCTION}/treebolicRoyalsIAB-production-release.apk
"

function get_apks() {
	for apk in $all; do
		src=`readlink -m ${apk}`
		>&2 echo -n ${src}
		if [ -e "${src}" ]; then
			echo "${src}"
			>&2 echo -e "${GREEN} EXISTS${RESET}"
		else
			>&2 echo -e "${YELLOW} !EXISTS${RESET}"
		fi
	done
}

#get_apks

export APKS=`get_apks`
echo -e "${BLUE}${APKS}${RESET}"
