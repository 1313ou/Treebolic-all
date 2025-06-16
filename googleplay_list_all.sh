#!/bin/bash

source define_colors.sh
source define_googleplay_apps.sh

echo -e "${M}build.gradle\n$(grep 'version' build.gradle)${Z}"

verbose=$1
for PACKAGE in ${PACKAGES}; do
	echo -e "${MAGENTA}${p}${RESET}"
	python2 googleplay_list.py ${verbose} ${PACKAGE}
	echo
done
