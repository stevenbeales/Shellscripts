#!/bin/bash
#
# say you have a list of files that contain the string 'foo'
#
# If you want to remove that string from the filenames, then type
#
#     > mvr foo list
#
# where list is something like name_foo_3.txt or *foo* etc.
#
# If you want to replace that string with another, say 'bar', then type
#
#     > mvr -r bar foo list
#
# Note: removes or replaces first occurance of the string. Rerun to get
#       other occurrences of the string.

WRONG_ARGS=65
dargs=2
if [ $# -lt $dargs ]
then
    echo "Usage: mvr [-d -r newstring] oldstring file_list"
    echo "send -d for a dry run"
    exit $WRONG_ARGS
fi

newstring=""
dryrun="n"
while getopts "r:d" Option
  do
  case $Option in
      r)  newstring=$OPTARG ;;
      d) dryrun="y" ;;
      [?]) echo "Usage: mvr [-r newstring] oldstring file_list"
           exit $WRONG_ARGS
           ;;  
  esac
done
shift $(($OPTIND - 1))

oldstring=$1
shift

if [[ "$dryrun" == "y" ]]; then
    echo "This is a dry run, no files will be moved"
fi
for args
  do
  rname=`echo $args | sed "s/$oldstring/$newstring/"`
  if [[ "$dryrun" == "y" ]]; then
      echo "$args -> $rname"
  else
      [ ! -f $rname ] && mv -v "$args" $rname
  fi
done
exit