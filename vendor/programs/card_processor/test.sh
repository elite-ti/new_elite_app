#!/bin/bash

function test {
  filename=$1
  expected=$2

  folder='/home/charlie/Desktop/samples_png'
  source_path=$folder/$filename.png
  destination_path=$folder/normalized_$filename.png

  result=$(./b_type $source_path $destination_path)
  if [ "$result" == "$expected" ]
  then
    echo "=> Success!"
  else
    echo "=> Error"
    echo "Result:"
    echo "$result"
    echo "Expected:"
    echo "$expected"
    echo ""
  fi
}

echo -e "\n=> Testing b_type"
rm -f b_type
gcc -std=c99 b_type.c lodepng.c -lm -o b_type

zeros='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'
test sample1 0246864AEBDCBDAEDEEEBEEWEEBEEDEEEBEED$zeros
test sample2 0001234ABCZEZWCZBDEEEDCBBCDCZBCZBDAEC$zeros
test sample3 166Z921BCDEBABACAAZZZZBZZEZZBCCCCWCDE$zeros
test sample4 ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ$zeros