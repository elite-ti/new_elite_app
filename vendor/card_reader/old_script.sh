#!/bin/bash

echo "=> Removing card_reader"
rm card_reader

echo "=> Compiling program"
gcc -o card_reader card_reader.c -ltiff

echo "=> Running program"
cat old_input | ./card_reader