#!/bin/bash

source define_colors.sh
source define_googleplay_apps.sh

echo -en "${M}"
./find-version.sh
echo -en "${Z}"

verbose=$1
for PACKAGE in ${PACKAGES}; do
	echo -e "${MAGENTA}${p}${RESET}"
	python2 googleplay_list.py ${verbose} ${PACKAGE}
	echo
done
