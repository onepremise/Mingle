#!/bin/bash

for TEST in `ls test-*.exe`
do
  echo Executing $TEST...
  if [ "$TEST" == "test-ftruncate.exe" ]; then
      ./test-ftruncate.exe "data/test-file.txt"
  else
      ./$TEST
  fi
  
  echo Complete.
  echo
done
