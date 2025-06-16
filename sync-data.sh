#/bin/bash

dir_eclipse=/opt/devel/treebolic/current
dir_studio=/opt/devel/android-treebolic-as

declare -A data
data=(
[Treebolic/treebolic]="data/zipped/demo.zip data/zipped/serialized.zip data/zipped/test.zip data/zipped/tests.zip"
[TreebolicFungi/treebolicFungi]="treebolic-browser-fungi/data.zip"
[TreebolicPlants/treebolicPlants]="data/zipped/plantae.zip"
[TreebolicPlugins/treebolicDotPlugin]="data/zipped/dot.zip"
[TreebolicPlugins/treebolicOwlPlugin]="data/zipped/owl.zip"
[TreebolicServices/treebolicOwlServices]="data/zipped/owl.zip"
)

declare -A mapped
mapped=(
[plantae.zip]="data.zip"
)

declare -A eclipse
eclipse=([java]=src)

declare -A studio
studio=([java]=src/main/java [assets]=src/main/assets)

for d in ${!data[@]}; do 
	s=${dir_eclipse}
	for f in ${data[${d}]}; do 
		b=`basename ${f}`
		if [ ! -z "${mapped[${b}]}" ]; then
			b=${mapped[${b}]}
			echo "${f} mapped to ${b}"
		fi
		src=${dir_eclipse}/${f}
		if [ ! -e ${src} ]; then
			echo FAIL ${src}
		fi
		dest=${dir_studio}/${d}/${studio[assets]}/${b}
		echo ${src} ${dest}
		#if [ -e ${dest} ]; then
		#	echo EXISTS ${dest}
		#fi
		cp -pi ${src} ${dest}
		#ls -l ${dir_studio}/${d}/${f}
	done
	echo
done

