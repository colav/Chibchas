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
start=1
end=$(($start+1))
echo $start - $end
chibchas_institulac --gdrive_path=/tmp/test -remove_tmp --start=$start --end=$end << EOF
$1
EOF

grupo=$(./get_group.py $start)



assert "ls -l /tmp/test/ | wc -l" 5

#grupo=$(cat /tmp/test/DB.json  | awk -F'"COL Grupo": ' '{print $3}' | awk -F"}" '{print $1}'| awk -F'"' '{print $2}')

assert "if [ -s '/tmp/test/'$grupo'' ]; then echo 1; else echo 2;fi" 1

assert_end twogroups
