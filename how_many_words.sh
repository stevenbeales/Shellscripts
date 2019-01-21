#!/bin/bash

# Usage: ./how_many_words.sh "word1|word2" "inputpath" "input type"

# Words separated by |
Words="$1"
InputPath="$2"
InputType="$3"

TempOutputPath="outttemp.txt"

# If it's a pdf file
if [ "$InputType" == "pdf" ] || [ "$InputType" == "PDF" ]
then
  pdftotext -layout "$InputPath" "$TempOutputPath"
  InputPath="$TempOutputPath"
fi

# If it's a URL
if [ "$InputType" == "url" ] || [ "$InputType" == "URL" ]
then
  curl "$InputPath" >| "$TempOutputPath"
  InputPath="$TempOutputPath"
fi

# Compute number of occurrences of each word
grep -E -i -w -c "$Words" "$InputPath"

# Remove temporary output file
rm -f "$TempOutputPath"