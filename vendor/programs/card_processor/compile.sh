#!/bin/bash

echo "=> Removing binaries"
rm scan angle

echo "=> Compiling programs"
gcc -o scan scan.c -ltiff
gcc -o angle angle.c -ltiff