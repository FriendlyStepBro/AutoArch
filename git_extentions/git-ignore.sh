#!/bin/bash
if [ ! -f .gitignore ]; then
   echo ".gitignore file not found. Creating one."
   touch .gitignore
fi

if [ -z "$1" ]; then
   echo "Please provide a file or directory to add to .gitignore."
   exit 1
fi

echo "$1" >> .gitignore
echo "$1 added to .gitignore"
