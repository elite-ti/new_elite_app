#!/bin/bash
parameters='
1
1
0.4
2
377
20
10
9
33
34
ABCDE
552
914'

path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
chmod +r $1
echo $parameters | $path/card_scanner $1