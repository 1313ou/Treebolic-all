#!/bin/bash

find_it()
{
	find . -not -path './archive/*' -name "build.gradle.kts" -print
}
find_it

