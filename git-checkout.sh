#!/bin/bash

source define_colors.sh

branch="$1"
if [ -z "$branch" ]; then
  exit 1
  fi

DIRS=`./find-git-repos.sh`
for d in $DIRS; do
	echo -e "${MAGENTA}$d${RESET}"
	pushd $d > /dev/null
	git switch -C $branch
	popd > /dev/null
done

