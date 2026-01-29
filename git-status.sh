#!/bin/bash

source define_colors.sh

DIRS=`./find-dirs-projects.sh`
for d in $DIRS; do
	echo -e "${MAGENTA}$d${RESET}"
	pushd $d > /dev/null
	git status
	popd > /dev/null
done

