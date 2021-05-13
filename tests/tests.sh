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
echo "============================================"
./test4.sh $1 $2

echo "kill geckcodriver (y/n):"
read k
if [ "$k"  == "y" ];then
    kill -9 $(ps caux | grep geckodriver | awk '{print $2}')
fi
rm -rf /tmp/test/
