# author: togra93
# last updated: 2017-03-31
# configure shell, using given files
# basically backup old ones and create symlinks

vBASEDIR=$(pwd | sed s#"/bin$"##)
vBINDIR=~/bin
vGITDIR=~/git
# set true, if you want to check and even clone the liquidprompt setup
vLIQPROM=false
vLIQPROMLINK="https://github.com/nojhan/liquidprompt.git"

# link dotfiles 
vDOTFILES=$vBASEDIR/dotfiles/.[!.]*
for i in $vDOTFILES;do
    vORIGFILE=~/$(basename $i)
    [ -e $vORIGFILE ] && mv $vORIGFILE $vORIGFILE.old
    ln -s $i ~
done

# make bin folder and link binaries
[ ! -d $vBINDIR ] && mkdir $vBINDIR
for i in $vBASEDIR/bin/*;do
    [ $(basename $i) != $(basename $0) ] && ln -s $i $vBINDIR
done

# optional: clone liquidprompt and link config
[ $vLIQPROM ] && {
    vLIQPROMORIG=~/.liquidpromptrc
    if [ -e $vLIQPROMORIG ];then
        mv $vLIQPROMPORIG $vLIQPROMORIG.old
    else
       [ ! -d $vGITDIR ] && mkdir $vGITDIR
       git clone -q $vLIQPROMLINK $vGITDIR
    fi
    ln -s $vBASEDIR/liquidprompt/.liquidpromptrc $vLIQPROMORIG 
}

# finally source .bashrc
. ~/.bashrc
