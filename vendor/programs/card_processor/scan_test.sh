#!/bin/bash

echo "=> Removing binary"
rm scan

echo "=> Compiling"
gcc -o scan scan.c -ltiff

echo "=> Scanning"
./scan /home/charlie/Desktop/answer_card.tif 1 0.4 2 377 20 10 9 33 34 ABCDE 552 914