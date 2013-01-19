#!/bin/bash

function test {
  filename=$1
  expected=$2

  desktop='/home/charlie/Desktop'
  source_path=$desktop/$filename.png
  destination_path=$desktop/normalized_$filename.png

  result=$(./b_type $source_path $destination_path)
  if [ "$result" == "$expected" ]
  then
    echo "=> Success!"
  else
    echo "=> Error"
    echo "Result: $result"
    echo "Expected: $expected"
  fi
}

echo -e "\n=> Testing b_type"
rm b_type
gcc b_type.c lodepng.c -lm -o b_type

zeros='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
test sample1 0246864AEBDCBDAEDEEEBEEWEEBEEDEEEBEED$zeros
test sample2 0001234ABCZEZWCZBDEEEDCBBCDCZBCZBDAEC$zeros
test sample3 166Z921BCDEBABACAAZZZZBZZEZZBCCCCWCDE$zeros
test sample4 ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ$zeros