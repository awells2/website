#!/bin/sh

if [ $# -ne 3 ]
  then
    echo "Must supply at least 3 arguments"
    echo "Usage: [filename1] [filename2] [filename3]..."
    exit 1
fi

sqlite3 development.sqlite3 << EOS
.mode csv
.import $1 confluency
.import $2 sytoxGreen
.import $3 NLS

