#!/bin/bash

./find-buildgradles.sh | sed 's/\.//g' | sed 's/\/buildgradle//g' | tr '/' ':'

