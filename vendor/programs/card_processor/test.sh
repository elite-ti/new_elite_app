#!/bin/bash
execute='scan'

echo "=> Removing binary"
rm $execute

echo "=> Compiling"
gcc -o $execute $execute.c -ltiff

echo "=> Scanning old answer card"
path='/home/charlie/Desktop/old_answer_card.tif'
threshold='0.4'
number_of_zones='1'
number_of_groups='2'
space_between_groups='377'
questions_per_group='20'
alternatives='ABCDE'
marks_horizontal_diameter='33'
marks_vertical_diameter='34'
group_horizontal_position='552'
group_vertical_position='914'
group_horizontal_size='209'
group_vertical_size='840'

expected='CECECDDDDDDDDDDDWECBABCDECWCDCWECDCDBDCD'

result=$(./$execute $path $threshold $number_of_zones $number_of_groups \
  $space_between_groups $questions_per_group $alternatives $marks_horizontal_diameter \
  $marks_vertical_diameter $group_horizontal_position $group_vertical_position \
  $group_horizontal_size $group_vertical_size)

if [ "$result" == "$expected" ]
then
  echo "=> Success!"
else
  echo "=> Error"
  echo "Result: $result"
  echo "Expected: $expected"
fi

# echo "=> Scanning new answer card"
# card_path='/home/charlie/Desktop/new_answer_card.tif'
# parameters='2 0.4 1 0 7 969 460 80 43 0123456789 281 528 2 600 50 495 3471 88 43 ABCDE 183 1050'
# expected='0246864AEBDCBDAEDEEEBEEWEEBEEDEEEBEEDZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'

# result=$(./$execute $card_path $parameters)

# if [ "$result" == "$expected" ]
# then
#   echo "=> Success!"
# else
#   echo "=> Error"
#   echo "Result: $result"
#   echo "Expected: $expected"
# fi