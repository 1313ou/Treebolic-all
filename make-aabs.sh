#!/bin/bash

source define_colors.sh

case "$1" in
-z)
	echo "clean start"
	./gradlew --stop
	./gradlew clean
	;;
*)
	echo "resuming"
	;;
esac

#specific targets
apps="treebolic 
treebolicFilesServices treebolicOwlServices treebolicWordNetServices
treebolicFungi treebolicPlants treebolicRoyals 
treebolicSumo 
treebolicContacts 
treebolicWordNet treebolicWordNetForAmazon treebolicWordNetForGoogle"
for a in $apps; do
	echo -e "${Y}${a}${E}"
	./gradlew ${a}:bundleRelease 
done

apps_prod="treebolicWordNetIAB treebolicRoyalsIAB"
for a in $apps_prod; do
	echo -e "${Y}${a}${E}"
	./gradlew ${a}:bundleProductionRelease
done

#if ./gradlew bundleRelease bundleProductionRelease; then
#	./apk-version.sh
#else
#	echo "failed"
#fi

