#!/bin/sh

WRONG_ARGS=65
dargs=2
if [ $# -lt $dargs ]
then
    echo "Usage: rmspaces files"
    echo "Removes spaces from file names and replace with a dash -"
    exit $WRONG_ARGS
fi



for args; do 
    newname=$(echo $args | tr ' ' -)
    [ ! -f $newname ] && mv -v "$args" $newname
done