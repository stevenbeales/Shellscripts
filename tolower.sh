#!/bin/sh

WRONG_ARGS=65
dargs=2
if [ $# -lt $dargs ]
then
    echo "Usage: tolower files"
    echo "Convert file names to all lower case"
    exit $WRONG_ARGS
fi

for args; do
    newname=$(echo $args | tr A-Z a-z)
    [ ! -f $newname ] && mv -v "$args" $newname
done