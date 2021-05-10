#!/usr/bin/env bash
if [ ! "$1" ]; then
    echo USAGE: $0 InstituLAC_login [user]
    exit
fi

./test.sh $1 $2
echo "============================================"
./test2.sh $1 $2
echo "============================================"
./test3.sh $1 $2
