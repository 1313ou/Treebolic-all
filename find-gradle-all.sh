#!/bin/bash

find_it()
{
	find . -name "build.gradle" -not -path "./archive/*"
}
find_it

