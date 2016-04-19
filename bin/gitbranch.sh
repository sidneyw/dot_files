#!/bin/bash
branch=$(git branch 2> /dev/null)

if [[ $? == 0 ]]
then
	echo "$branch" | grep "\*" | cut -d " " -f2
else 
	echo ""
fi
