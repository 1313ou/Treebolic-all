#!/bin/bash

source "lib-artwork.sh"

dirresources=../src/main/resources/treebolic/provider/wordnet/kwi/images

icon="*.svg"

make_png "${icon}" 64 h "${dirresources}"

check_dir "${dirresources}"
