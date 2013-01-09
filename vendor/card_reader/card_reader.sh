#!/bin/bash

rm -v card_reader
gcc -o card_reader card_reader.c
cat input | ./card_reader