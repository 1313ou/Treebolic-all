#!/usr/bin/bash

D="./output"
echo $1 $2
if [ ! -z "$1" ]; then
  D="$1"
  fi
if [ ! -z "$2" ]; then
  seedsDay=$(readlink -f "$2")
  seedsDay="-f $2"
else
        echo "Day seeds needed"
        exit 3
  fi
if [ ! -z "$3" ]; then
  seedsNight=$(readlink -f "$3")
  seedsNight="-f $3"
else
        echo "Night seeds needed"
        exit 4
  fi

source define_colors.sh
if [ ! -e "${D}" ]; then
        echo -e "${R}app   ${D}$Z"
        exit 1
fi


echo -e "${M}app                ${D}$Z"
echo -e "${M}seeds day          ${seedsDay}$Z"
echo -e "${M}seeds night        ${seedsNight}$Z"

# run

mkdir -p "$D/values"
mkdir -p "$D/values-night"

./run.sh -o colors    $seedsDay   -x > "$D/values/colors_theme.xml"
./run.sh -o colors -d $seedsNight -x > "$D/values-night/colors_theme.xml"
