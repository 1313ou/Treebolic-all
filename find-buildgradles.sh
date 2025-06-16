#!/bin/bash

find_it()
{
	find . -name "build.gradle" | xargs grep -l "apply plugin:.'com.android.application'"
}
find_it

