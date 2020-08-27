#!/bin/bash
set -e
shopt -s extglob

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

git add manifest* timestamp.txt
git config --local user.email "mirror@decentespresso.com"
git config --local user.name "Decent Espresso"
git commit -m"Auto update Manifest following push"
git push origin main
