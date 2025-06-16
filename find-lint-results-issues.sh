#!/bin/bash

find_it()
{
	find . -name "lint-results*.html" | xargs grep -LI "No Issues"
}
find_it

