#!/bin/bash
#Change all words in a file that match the parameters. Example: replacewords.sh file.txt wordToReplace wordToBeReplacedWith

file=$1
wordToReplace=$2
wordToBeReplacedWith=$3
#with the command sed , we can replace the word inside the file with the desired word.
sed -i "s/$wordToReplace/$wordToBeReplacedWith/g" "$file"




