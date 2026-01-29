#!/bin/bash

source define_colors.sh

RELEASE=build/outputs/bundle/release
ext=aab
all="
Treebolic/treebolic/${RELEASE}/treebolic-release.$ext
TreebolicServices/treebolicFilesServices/${RELEASE}/treebolicFilesServices-release.$ext
TreebolicServices/treebolicOwlServices/${RELEASE}/treebolicOwlServices-release.$ext
TreebolicServices/treebolicWordNetServices/${RELEASE}/treebolicWordNetServices-release.$ext

TreebolicWordNet/treebolicWordNet/${RELEASE}/treebolicWordNet-release.$ext
TreebolicWordNet/treebolicWordNetForAmazon/${RELEASE}/treebolicWordNetForAmazon-release.$ext
TreebolicWordNet/treebolicWordNetForGoogle/${RELEASE}/treebolicWordNetForGoogle-release.$ext

TreebolicContacts/treebolicContacts/${RELEASE}/treebolicContacts-release.$ext
TreebolicFungi/treebolicFungi/${RELEASE}/treebolicFungi-release.$ext
TreebolicSumo/treebolicSumo/${RELEASE}/treebolicSumo-release.$ext
TreebolicPlants/treebolicPlants/${RELEASE}/treebolicPlants-release.$ext
TreebolicRoyals/treebolicRoyals/${RELEASE}/treebolicRoyals-release.$ext
"

function get_aabs() {
	for aab in $all; do
		src=`readlink -m ${aab}`
		if [ ! -e "${src}" ]; then
		  >&2 echo -n ${src}
			>&2 echo -e "${RED} !EXISTS${RESET}"
		else
		  # >&2 echo -n ${src}
		  #	>&2 echo -e "${GREEN} EXISTS${RESET}"
      echo "${src}"
		fi
	done
}

#get_aabs
export AABS=`get_aabs`
echo $AABS