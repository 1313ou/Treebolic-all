#!/usr/bin/bash
  

source define_colors.sh
source define_data.sh

H=..

all="$@"
if [ -z "$all"]; then
  all="${apps}"
  fi

./convert_all_gpa.sh

for app in ${all}; do
  value=${app2path[$app]}
  t=$(basename "$value")
  d=$(dirname "$value")
  res=$H/$d/src/main/res
  seedsDay=${t}-day.txt 
  seedsNight=${t}-night.txt
  echo -e "${Y}${app} ${t}${Z} ${B}$res${Z} ${M}$seedsDay $seedsNight${Z}"

  if [ ! -e "$seedsDay" ]; then
        echo -e "${R}${seedsDay}${Z}"
        continue
  fi
  if [ ! -e "$H/$d/$t-night.gpa" ]; then
        echo -e "${R}${seedNight}${Z}"
        continue
  fi
 
  ln -sf "$H/$d/$t-day.gpa"
  ln -sf "$H/$d/$t-night.gpa"
  
  ./build-theme.sh "$res" "$seedsDay" "$seedsNight"

done  
