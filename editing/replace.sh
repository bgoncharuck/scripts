#!/bin/sh
if [ $# -ge 3 ]
then
  if [ "$4" != "-g" ]
  then
    sed -i "s/$2/$3/" $1
  elif [ "$4" == "-g" ]
  then
    sed -i "s/$2/$3/g" $1
  fi
else
  echo "Wrong number of arguments"
fi
