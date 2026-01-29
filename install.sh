#!/bin/bash


device=
if [ "-device" == "$1" ]; then
	shift
	device=$1
	deviceswitch="-s ${device}"
	shift 
fi

option=-r
#option=

DIR=dist/releases

iwordnet="org.treebolic.wordnet.browser org.treebolic.wordnet.browser.amazon org.treebolic.wordnet.browser.google org.treebolic.wordnet.browser.iab"
itreebolic=org.treebolic
iones="org.treebolic.fungi org.treebolic.royals2 org.treebolic.plants"
iservices="org.treebolic.files.service org.treebolic.owl.service org.treebolic.wordnet.service"
icontact="org.treebolic.contacts"
iall="$itreebolic $iones $icontact $iwordnet $iplugins $iservices"

wordnet="treebolicWordNet-release.apk treebolicWordNetForAmazon-release.apk treebolicWordNetForGoogle-release.apk treebolicWordNetIAB-production-release.apk "
treebolic=treebolic-release.apk
ones="treebolicFungi-release.apk treebolicRoyals-release.apk treebolicPlants-release.apk"
services="treebolicFilesServices-release.apk treebolicOwlServices-release.apk treebolicWordNetServices-release.apk"
contact=" treebolicContacts-release.apk"
all="$treebolic $ones $contact $wordnet $services"

source define_colors.sh

case "$1" in
	"-w")
		shift
		iall="$iwordnet"
		all="$wordnet"
		;;
	"-t")
		shift
		iall="$itreebolic"
		all="$treebolic"
		;;
	"-c")
		shift
		iall="$icontact"
		all="$contact"
		;;
	"-a|*")
		shift
		iall="$iwordnet $icontact $itreebolic"
		all="$wordnet $contact $treebolic"
		;;
esac

adb kill-server
if [ "$1" == "-u" -o "$1" == "-f" ]; then

	for k in $iall; do
		echo -e "${YELLOW}* uninstall ${k}${RESET}"
		adb ${deviceswitch} uninstall ${k}
	done
	if [ "$1" == "-u" ]; then
		exit
	fi
fi

for k in $all; do
	echo -e "${CYAN}* ${k}${RESET}"
	adb ${deviceswitch} install ${option} ${DIR}/$k
done
