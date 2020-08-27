#!/bin/bash
set -e
shopt -s extglob

echo "Rebaseing local changes on top of upstream..."
git config --local user.email "mirror@decentespresso.com"
git config --local user.name "Decent Espresso"
git status
git restore .
git clean -dxf .
echo "--- Addind upstream remote ---"
git fetch https://github.com/oscar-b/de1-mirror
echo "--- Rebasing---"
git rebase FETCH_HEAD
git status

if git diff origin/main HEAD
then
  exit 0
fi
echo "--- Creating Manifest ---"

TIMESTAMP=`cat timestamp.txt`

TIMESTAMP=$(($TIMESTAMP+1))

echo $TIMESTAMP > timestamp.txt

export TIMESTAMP

if [ -f manifest.tdb ] ; then
	rm manifest.tdb
fi
if [ -f manifest.gz ] ; then
	rm manifest.gz
fi

function printFile {
	FILESIZE=$(wc -c "$1" | awk '{print $1}')
    CHECKSUM=$(sha256sum "$1" | awk '{print $1}')
	echo "\"$1\" $FILESIZE $TIMESTAMP $CHECKSUM"
}

export -f printFile

find * -type f -printf "\"%p\"\n"  | grep -v "\"patches" |  xargs -n1 -I {} bash -c "printFile \"{}\"" | tee manifest.tdb

gzip -c manifest.tdb > manifest.gz

git add manifest.tdb manifest.gz
git commit -m "Update Manifest for upstream $TIMESTAMP"

git push -f origin main
