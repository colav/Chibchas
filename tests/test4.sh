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
rm -rf /tmp/chibchas/"$1"
rm -rf /tmp/test
grupo=COL0119469
echo $grupo
chibchas_institulac --gdrive_path=/tmp/test -remove_tmp --COL_Group=$grupo << EOF
$1
EOF


assert "ls -l /tmp/test/ | wc -l" 5

assert "if [ -s '/tmp/test/'$grupo'' ]; then echo 1; else echo 2;fi" 1

assert_end twogroups
