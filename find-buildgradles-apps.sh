#!/bin/bash

find_it()
{
	find . -not -path './archive/*' -name "build.gradle.kts" | xargs grep -l "alias(libs.plugins.androidApplication)$"
}
find_it
