#/bin/bash

dir_eclipse=/opt/devel/treebolic/treebolic-3.0.0
dir_studio=/opt/devel/android-treebolic-as

proj_eclipse0="treebolic-glue-iface treebolic-lib-model treebolic-lib-view treebolic-mutable treebolic-graph treebolic-loadbalancer treebolic-provider-wordnet-jwi"
proj_studio0="TreebolicLib/treebolicGlueIface TreebolicLib/treebolicLibModel TreebolicLib/treebolicLibView TreebolicLib/treebolicMutable TreebolicLib/treebolicGraph TreebolicLib/treebolicLoadBalancer TreebolicWordNet/treebolicWordNetProvider"

proj_eclipse=($proj_eclipse0)
proj_studio=($proj_studio0)

declare -A eclipse
eclipse=([java]=src)

declare -A studio
studio=([java]=src/main/java)

for ((i=0;i<${#proj_eclipse[@]};i++)); do
	e1=${proj_eclipse[i]}
	s1=${proj_studio[i]}
	#echo "${e1} -- ${s1}"
	for t in ${!eclipse[@]}; do
		#echo "${t}"
		e2=${dir_eclipse}/${e1}/${eclipse[$t]}
		s2=${dir_studio}/${s1}/${studio[$t]}
		echo "${e2} -- ${s2}"
		meld ${e2} ${s2}
	done
done

exit

