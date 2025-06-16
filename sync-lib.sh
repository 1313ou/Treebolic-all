#/bin/bash

dir_eclipse=/opt/devel/treebolic/treebolic-3.0.0
dir_studio=/opt/devel/android-treebolic-as

declare -A libs
libs=(
[treebolic-balancer.jar]=" TreebolicPlugins/treebolicFilesPlugin/libs/ TreebolicServices/treebolicFilesServices/libs/"
[treebolic-provider-text-indent.jar]=" Treebolic/treebolic/libs/"
[treebolic-provider-text-indent-tre.jar]=" Treebolic/treebolic/libs/"
[treebolic-provider-text-pair.jar]=" Treebolic/treebolic/libs/"
[treebolic-provider-xml-dom.jar]=" TreebolicOne/treebolicOne/libs/ Treebolic/treebolic/libs/"

[treebolic-provider-files.jar]="TreebolicPlugins/treebolicFilesPlugin/libs/ TreebolicServices/treebolicFilesServices/libs/"
[treebolic-provider-graphviz.jar]="TreebolicPlugins/treebolicDotPlugin/libs/"
[treebolic-provider-owl-owlapi-min.jar]=" TreebolicPlugins/treebolicOwlPlugin/libs/ TreebolicServices/treebolicOwlServices/libs/"

[treebolic-provider-sqlx-common.jar]=" TreebolicOne/treebolicSqliteProvider/libs/"

#[treebolic-provider-wordnet-jwi.jar]=" TreebolicWordNet/treebolicWordNetLib/libs/"
[treebolic-provider-wordnet-jwi-nodata.jar]=" TreebolicServices/treebolicWordNetServices/libs/"
)

declare -A eclipse
eclipse=([java]=src)

declare -A studio
studio=([java]=src/main/java)

RED='\u001b[31m'
GREEN='\u001b[32m'
YELLOW='\u001b[33m'
BLUE='\u001b[34m'
MAGENTA='\u001b[35m'
CYAN='\u001b[36m'
RESET='\u001b[0m'

for f in ${!libs[@]}; do 
	s=${dir_eclipse}/lib/${f}
	for d in ${libs[${f}]}; do 
		echo -e "${MAGENTA}${f}${RESET}"
		echo -e "${BLUE}${s}${RESET} -> ${CYAN}${d}${RESET}"
		cp -pi ${s} ${dir_studio}/${d}
		#ls -l ${dir_studio}/${d}/${f}
		echo -en "${GREEN}"
		stat -t ${dir_studio}/${d}/${f}
		echo -e "${RESET}"
		echo
	done
	echo
done

