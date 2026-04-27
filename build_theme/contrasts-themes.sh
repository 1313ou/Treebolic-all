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
  echo -e "${bY}${K}${t}${Z} $seedsDay $seedsNight"

  if [ ! -e "$seedsDay" ]; then
        echo -e "${R}${seedsDay}${Z}"
        continue
  fi
  if [ ! -e "$H/$d/$t-night.gpa" ]; then
        echo -e "${R}${seedNight}${Z}"
        continue
  fi

  echo -e "${bB}${W}day${K} $seedsDay${Z}"
  echo -en "${C}";./run.sh -o colors1 -f "$seedsDay";echo -en "${Z}"
  echo -en "${C}";./run.sh -o map -f "$seedsDay";echo -en "${Z}"
  echo -e "${M}${t} custom / primary${Z}"
  ./run.sh -o name_gpick -f "$seedsDay" -i 0,1 || echo -e "${R}FAIL${Z}"
  echo -en "${B}";./run.sh -o contrasts -f "$seedsDay" -i 1,0 || echo -e "${R}FAIL${Z}";echo -en "${Z}"
  echo -e "${M}${t} custom / secondary${Z}"
  ./run.sh -o name_gpick -f "$seedsDay" -i 0,2 || echo -e "${R}FAIL${Z}"
  echo -en "${B}";./run.sh -o contrasts -f "$seedsDay" -i 2,0 || echo -e "${R}FAIL${Z}";echo -en "${Z}"
  echo -e "${M}${t} custom / tertiary${Z}"
  ./run.sh -o name_gpick -f "$seedsDay" -i 0,3 || echo -e "${R}FAIL${Z}"
  echo -en "${B}";./run.sh -o contrasts -f "$seedsDay" -i 3,0 || echo -e "${R}FAIL${Z}";echo -en "${Z}"

  echo -e "${bB}${W}night ${K} $seedsNight${Z}"
  echo -en "${C}";./run.sh -o colors1 -d -f "$seedsNight";echo -en "${Z}"
  echo -en "${C}";./run.sh -o map -d -f "$seedsNight";echo -en "${Z}"
  echo -e "${M}${t} custom / primary${Z}"
  ./run.sh -o name_gpick -f "$seedsNight" -i 0,1 || echo -e "${R}FAIL${Z}"
  echo -en "${B}";./run.sh -o contrasts -f "$seedsNight" -i 1,0 || echo -e "${R}FAIL${Z}";echo -en "${Z}"
  echo -e "${M}${t} custom / secondary${Z}"
  ./run.sh -o name_gpick -f "$seedsNight" -i 0,2 || echo -e "${R}FAIL${Z}"
  echo -en "${B}";./run.sh -o contrasts -f "$seedsNight" -i 2,0 || echo -e "${R}FAIL${Z}";echo -en "${Z}"
  echo -e "${M}${t} custom / tertiary${Z}"
  ./run.sh -o name_gpick -f "$seedsNight" -i 0,3 || echo -e "${R}FAIL${Z}"
  echo -en "${B}";./run.sh -o contrasts -f "$seedsNight" -i 3,0 || echo -e "${R}FAIL${Z}";echo -en "${Z}"
  echo
done
