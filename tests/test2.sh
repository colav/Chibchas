. assert.sh
if [ ! "$1" ]; then
    echo USAGE: $0 InstituLAC_login [user]
    exit
fi

if [ "$2" == "user" ]; then
    #python3 setup.py develop --user
    export PATH=$HOME/.local/bin:$PATH
    #which chibchas_institulac
fi

#Safe: only if $1 exists
rm -rf /tmp/test

chibchas_institulac --gdrive_path=/tmp/test --start=1 --end=2 << EOF
$1
EOF

assert "ls -l /tmp/test/ | wc -l" 6

grupo=$(cat /tmp/test/DB.json  | awk -F'"COL Grupo": ' '{print $3}' | awk -F"}" '{print $1}'| awk -F'"' '{print $2}')

assert "if [ -s '/tmp/test/'$grupo'' ]; then echo 1; else echo 2;fi" 1

assert_end twogroups
