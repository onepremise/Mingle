#!/bin/bash

for TEST in `ls test-*.exe`
do
  filename="${TEST%.*}"
  echo Checking $filename.sh...
  if [ -e "$filename.sh" ]; then
      echo Executing $filename.sh...
      ./$filename.sh 
  elif [ "$TEST" == "test-ftruncate.exe" ]; then
      echo Executing ./test-ftruncate.exe "data/test-file.txt"...
      ./test-ftruncate.exe "data/test-file.txt" || exit 1
  else
      echo Executing $TEST...
      ./$TEST
  fi
  
  echo Complete.
  echo
done
