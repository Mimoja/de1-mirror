#!/bin/bash
set -e
shopt -s extglob

echo "Rebaseing local changes on top of upstream..."
git config --local user.email "mirror@decentespresso.com"
git config --local user.name "Decent Espresso"
git checkout main
git rebase upstream
git status

TIMESTAMP=`cat timestamp.txt`
FILES=`find . ! -path . | grep -v ".git\|.github" | sed "s/\.\///g" | sort `

function printFile {
	FILESIZE=$(wc -c $1 | awk '{print $1}')
    CHECKSUM=$(sha256sum $1 | awk '{print $1}')
	echo "\"$1\" $FILESIZE $TIMESTAMP $CHECKSUM"
}

echo $FILES | xargs -n1 -I {} bash -c 'echo  "\"{}\" `wc -c {}` "  ' >> manifest.tdb
gzip manifest.tdb

git stash save

git checkout upstream -B manifest

git stash pop
git add -a
git commit -m "Add Manifest"

git checkout main
git rebase manifest

git push -f
