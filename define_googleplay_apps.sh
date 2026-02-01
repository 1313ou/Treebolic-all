#!/bin/bash

export packages_treebolic="
	org.treebolic
"

export packages_services="
	org.treebolic.files
	org.treebolic.owl
"

export packages_ones="
	org.treebolic.royals2
	org.treebolic.fungi
	org.treebolic.owl.sumo
"

export packages_specifics="
	org.treebolic.contacts
"

export packages_wordnet="
	org.treebolic.wordnet.browser
"

export PACKAGES="
	${packages_treebolic}
	${packages_services}
	${packages_ones}
	${packages_specifics}
	${packages_wordnet}
"

declare -A PACKAGES_BY_KEY
export PACKAGES_BY_KEY=(
[treebolic]=org.treebolic

[treebolicFilesServices]=org.treebolic.files
[treebolicOwlServices]=org.treebolic.owl

[treebolicFungi]=org.treebolic.fungi
[treebolicSumo]=org.treebolic.owl.sumo
[treebolicRoyals]=org.treebolic.royals2

[treebolicContacts]=org.treebolic.contacts

[treebolicWordNet]=org.treebolic.wordnet.browser
)
export KEYS="${!PACKAGES_BY_KEY[@]}"

declare -A FLAVORS_BY_KEY
export FLAVORS_BY_KEY=(
[treebolic]=
[treebolicFilesServices]= 
[treebolicOwlServices]= 
[treebolicWordNetServices]=
[treebolicFungi]= 
[treebolicSumo]= 
[treebolicPlants]=
[treebolicRoyals]=
[treebolicContacts]=
[treebolicWordNet]= 
)

