#!/bin/bash

echo "=> Removing binaries"
rm scan

echo "=> Compiling programs"
gcc -o scan scan.c -ltiff