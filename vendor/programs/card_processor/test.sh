#!/bin/bash

echo -e "\n=> Testing scan"
execute='scan'
rm $execute
gcc -o $execute $execute.c -ltiff

echo "=> Old answer card"
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

result=$(./$execute $path $threshold $number_of_zones \
  $number_of_groups $space_between_groups $questions_per_group $alternatives \
  $marks_horizontal_diameter $marks_vertical_diameter \
  $group_horizontal_position $group_vertical_position \
  $group_horizontal_size $group_vertical_size)

if [ "$result" == "$expected" ]
then
  echo "=> Success!"
else
  echo "=> Error"
  echo "Result: $result"
  echo "Expected: $expected"
fi

# echo "=> New answer card"
# path='/home/charlie/Desktop/new_answer_card.tif'
# threshold='0.4'
# number_of_zones='2'

# number_of_groups='1'
# space_between_groups='0'
# questions_per_group='7'
# alternatives='0123456789'
# marks_horizontal_diameter='80'
# marks_vertical_diameter='43'
# group_horizontal_position='281'
# group_vertical_position='914'
# group_horizontal_size='969'
# group_vertical_size='528'

# number_of_groups_2='2'
# space_between_groups_2='600'
# questions_per_group_2='50'
# alternatives_2='ABCDE'
# marks_horizontal_diameter_2='88'
# marks_vertical_diameter_2='43'
# group_horizontal_position_2='183'
# group_vertical_position_2='1050'
# group_horizontal_size_2='495'
# group_vertical_size_2='3471'

# expected='0246864AEBDCBDAEDEEEBEEWEEBEEDEEEBEEDZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'

# result=$(./$execute $path $threshold $number_of_zones \
#   $number_of_groups $space_between_groups $questions_per_group $alternatives \
#   $marks_horizontal_diameter $marks_vertical_diameter \
#   $group_horizontal_position $group_vertical_position \
#   $group_horizontal_size $group_vertical_size \
#   $number_of_groups_2 $space_between_groups_2 $questions_per_group_2 $alternatives_2 \
#   $marks_horizontal_diameter_2 $marks_vertical_diameter_2 \
#   $group_horizontal_position_2 $group_vertical_position_2 \
#   $group_horizontal_size_2 $group_vertical_size_2)

# if [ "$result" == "$expected" ]
# then
#   echo "=> Success!"
# else
#   echo "=> Error"
#   echo "Result: $result"
#   echo "Expected: $expected"
# fi

echo -e "\n=> Testing angle"
execute='angle'
rm $execute
gcc -o $execute $execute.c -ltiff

echo "=> Old answer card"
path='/home/charlie/Desktop/old_answer_card.tif'
mark_width='68'
mark_height='40'

expected='0.3223141381'

result=$(./$execute $path $mark_width $mark_height)

if [ "$result" == "$expected" ]
then
  echo "=> Success!"
else
  echo "=> Error"
  echo "Result: $result"
  echo "Expected: $expected"
fi