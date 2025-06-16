#!/bin/bash

thisdir="`dirname $(readlink -m $0)`"
thisdir="$(readlink -m ${thisdir})"
dirapp=..
dirres=../src/main/res
dirassets=../src/main/assets/help/images
dirresources=../src/main/resources

function make_png(){
	#list="$1"
	#r=$2
	#dir="$3"
	#suffix="$4"
	mkdir -p $3
	for svg in $1; do
		png="${svg%.svg}$4.png"
		echo "${svg} -> $3/${png} @ $2"
		inkscape ${svg} --export-png=$3/${png} -h $2 > /dev/null 2> /dev/null
	done
}

function make_pngs(){
	list="$1"
	r0=$2
	dir=$3
	r1=$((r0 + r0 / 2))
	r2=$((r0 * 2))
	r3=$((r0 * 3))
	r4=$((r0 * 4))
	declare -A res
	res=([mdpi]=$r0 [hdpi]=$r1 [xhdpi]=$r2 [xxhdpi]=$r3 [xxxhdpi]=$r4)
	for k in ${!res[@]}; do 
		d="${dir}-${k}"
		mkdir -p ${d}
		r=${res[$k]}
		make_png "$1" ${r} "${d}"
	done
}

function make_res(){
	list="$1"
	r0=$2
	make_pngs "$1" $2 "${dirres}/drawable"
}

function make_resource(){
	list="$1"
	r0=$2
	subdir=$3
	if [ "${subdir}" == "" ]; then
		echo "null subdir"
	fi
	mkdir -p "${dirresources}/${subdir}"
	make_png "$1" $2 "${dirresources}/${subdir}"
}

function make_mipmap(){
	list="$1"
	r0=$2
	make_pngs "$1" $2 "${dirres}/mipmap"
}

function make_assets(){
	make_png "$1" $2 "${dirassets}"
}

function make_app(){
	make_png "$1" $2 "${dirapp}" -web
}

