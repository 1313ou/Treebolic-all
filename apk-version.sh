#!/bin/bash

if [ $# -ne 0 ]; then
	all=$*
else
	all=dist/releases/*.apk
fi

source define_colors.sh

for apk in ${all}; do
	echo -e "${MAGENTA}${apk}${RESET}"
	aapt l -a ${apk} | egrep '(package=|android:versionCode|android:versionName)'
done

for apk in ${all}; do
	echo -en "${MAGENTA}`basename ${apk}`${RESET} "
	n=`aapt l -a ${apk} | egrep versionCode | sed 's/^.*(type 0x10)/ /g'`
	echo -e "${BLUE}$(($n))${RESET}" 
done
