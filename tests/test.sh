. assert.sh
#python3 setup.py develop --user
export PATH=$HOME/.local/bin:$PATH
#which chibchas_institulac
if [ ! "$1" ]; then
    echo USAGE: $0 InstituLAC_login
    exit
fi

#Safe: only if $1 exists
rm -rf /tmp/chibchas/"$1"
rm -rf /tmp/test

chibchas_institulac --gdrive_path=/tmp/test --start=0 --end=1 << EOF
$1
EOF

echo "if [ -s /tmp/test/*/*.xlsx ]; then  echo 1; else echo 2; fi" > checkxlsx
assert "bash checkxlsx" 1

echo "if [ -s /tmp/test/DB.pickle ]; then  echo 1; else echo 2; fi" > checkxlsx
assert "bash checkxlsx" 1

echo "if [ -s /tmp/test/dfg.pickle ]; then  echo 1; else echo 2; fi" > checkxlsx
assert "bash checkxlsx" 1

echo "if [ -s /tmp/test/DB.json ]; then  echo 1; else echo 2; fi" > checkxlsx
assert "bash checkxlsx" 1

grupo=$(cat /tmp/test/DB.json  | awk -F'"COL Grupo": ' '{print $2}' | awk -F"}" '{print $1}'| awk -F'"' '{print $2}')

assert "if [ -s '/tmp/test/'$grupo'' ]; then echo 1; else echo 2;fi" 1

# exit code of `true` is expected to be 0
assert_raises "true"
# exit code of `false` is expected to be 1
assert_raises "false" 1
# end of test suite
assert_end examples
