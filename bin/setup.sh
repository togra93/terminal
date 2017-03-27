# author: togra93
# last updated: 2017-03-27
# configure shell, using given files
# basically backup old ones and create symlinks

vBINDIR=~/bin
vGITDIR=~/git
# set true, if you want to check and even clone the liquidprompt setup
vLIQPROM=false
vLIQPROMLINK="https://github.com/nojhan/liquidprompt.git"

# link dotfiles 
for i in ../dotfiles/.bash*;do
    vORIGFILE=~/$(basename $i)
    [ -e $vORIGFILE ] && mv $vORIGFILE $vORIGFILE.old
    ln -s $i ~/
done

# make bin folder and link binaries
[ ! -d $vBINDIR ] && mkdir $vBINDIR
for i in ../bin/*;do
    ln -s $i $vBINDIR

# optional: clone liquidprompt and link config
[ $vLIQPROM ] && {
    vLIQPROMORIG=~/.liquidpromptrc
    if [ -e $vLIQPROMORIG ];then
        mv $vLIQPROMPORIG $vLIQPROMORIG.old
    else
        [ ! -d $vGITDIR ] && mkdir $vGITDIR
        git clone -q $vLIQPROMLINK $vGITDIR
    fi
    ln -s ../liquidprompt/.liquidpromptrc ~/.liquidpromptrc
}

# finally source .bashrc
. ~/.bashrc
