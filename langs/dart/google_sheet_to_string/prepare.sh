#!/bin/bash

# HOW-To
# prepare "PATH_TO_CSV" "PATH_TO_DART_FILE"
# PATH_TO_CSV - csv file with new predictions
# PATH_TO_DART_FILE - file with bytedata for needed List of Strings
# exmple:
# prepare "some_csv.csv" "english/locale.dart"

# check arguments
if ! [[ "$#" =~ ^[2]$ ]]; then
    echo "incorrect number of arguments, must be:"
    echo "prepare \"PATH_TO_CSV\" \"PATH_TO_PREDICTIONS_FILE\""
    exit 1
fi

if [[ "$1" != *.csv ]]; then
    echo "first file is not in csv format"
    exit 1
fi


if [ -f "$1" ]; then
    echo "$1 found"
else 
    echo "$1 does not exist."
    exit 1
fi

if [ -f "$2" ]; then
    echo "$2 found"
else 
    echo "$2 does not exist."
    exit 1
fi

if grep -q 'List<String>' "$2"; then
    echo "second file is correct"
else
    echo "second file is not correct"
    exit 1
fi


# read files
csv=$(cat "$1" | sed -e 's/$/\$/' | tr -d '\r\n' )
dartFile=$(cat "$dartPath")

# resolve google sheet author copypaste flood
csv="${csv//$\"/$}"

# replace end of line with control characters
# Mac OS
csv="${csv//$/\r\n}"
# GNU core utils
# csv="${csv//$/\\\r\\\n}"

# replace " with control "
csv="${csv//\"/\\\"}"

# add to the file
toAdd="${dartFile/];/\"$csv\",$'\n'//$'\n'];}"
echo "$toAdd" > "$2"

echo "CSV are added to $2"
