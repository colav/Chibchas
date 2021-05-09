#!/usr/bin/env bash
if [ ! "$1" ]; then
    echo USAGE: $0 InstituLAC_login
    exit
fi

./test.sh $1
echo "============================================"
./test2.sh $1
echo "============================================"
./test3.sh $1
