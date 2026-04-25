#!/usr/bin/bash

declare -A app2path
export app2path=(
[contacts]=TreebolicContacts/treebolicContacts/contacts
[royals]=TreebolicRoyals/treebolicRoyalsLib/royals
[plants]=TreebolicPlants/treebolicPlants/plants
[wordnet]=TreebolicServices/treebolicWordNetServices/wordnet-services
[owl]=TreebolicServices/treebolicOwlServices/owl-services
[files]=TreebolicServices/treebolicFilesServices/file-services
)
export apps="${!app2path[@]}"

