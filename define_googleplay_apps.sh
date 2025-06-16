#!/bin/bash

export packages_treebolic="
	org.treebolic
"

export packages_services="
	org.treebolic.files
	org.treebolic.owl
"

export packages_ones="
	org.treebolic.royals.trial
	org.treebolic.fungi
	org.treebolic.owl.sumo
"

export packages_specifics="
	org.treebolic.contacts
"

export packages_wordnet="
	org.treebolic.wordnet.browser
	org.treebolic.wordnet.browser.google
"

export packages_suspended="
	org.treebolic.royals
	org.treebolic.wordnet.browser.iab
"

export packages_obsolete="
	org.treebolic.dot
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
[treebolicRoyalsIAB]=org.treebolic.royals.trial

[treebolicContacts]=org.treebolic.contacts

[treebolicWordNet]=org.treebolic.wordnet.browser
[treebolicWordNetForGoogle]=org.treebolic.wordnet.browser.google
)
export KEYS="${!PACKAGES_BY_KEY[@]}"


declare -A PACKAGES_UNUSED_BY_KEY
export PACKAGES_UNUSED_BY_KEY=(
[treebolicWordNetServices]=org.treebolic.wordnet

[treebolicPlants]=org.treebolic.plants

[treebolicRoyals]=org.treebolic.royals
[treebolicWordNetIAB]=org.treebolic.wordnet.browser.iab

[treebolicWordNetForAmazon]=org.treebolic.wordnet.browser.amazon
)

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
[treebolicRoyalsIAB]=-production
[treebolicContacts]=
[treebolicWordNet]= 
[treebolicWordNetForAmazon]= 
[treebolicWordNetForGoogle]=
[treebolicWordNetIAB]=-production
)

