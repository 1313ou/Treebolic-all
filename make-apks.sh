#!/bin/bash

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

if ./gradlew assemble; then
	./apk-version.sh
else
	echo "failed"
fi

