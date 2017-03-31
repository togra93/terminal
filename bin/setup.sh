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
    [ -e $vORIGFILE ] && mv $vORIGFILE $vORIGFILE.old \
        && echo "saving existing file $vORIGFILE to $vORIGFILE.old ..."
ln -s $i ~ && echo "creating symlink from $i to ~/$(basename $i) ..."
done

# make bin folder and link binaries
[ ! -d $vBINDIR ] && mkdir $vBINDIR && echo "creating binary directory $vBINDIR ..."
for i in $vBASEDIR/bin/*;do
    [ $(basename $i) != $(basename $0) ] && ln -sf $i $vBINDIR \
        && echo "creating symlink from $i to $vBINDIR/$(basename $i) ..."
done

# check terminator config
# need to write function to query installed software on multiple distros first

# optional: clone liquidprompt and link config
($vLIQPROM) && {
    vLIQPROMORIG=~/.liquidpromptrc
    if [ -e $vLIQPROMORIG ];then
        mv $vLIQPROMORIG $vLIQPROMORIG.old \
            && echo "saving existing file $vLIQPROMORIG to $vLIQPROMORIG.old"
    else
       [ ! -d $vGITDIR ] && mkdir $vGITDIR && echo "creating git directory $vGITDIR ..."
       git clone -q $vLIQPROMLINK $vGITDIR && echo "cloning liquidprompt repository ..."
    fi
    ln -s $vBASEDIR/liquidprompt/.liquidpromptrc $vLIQPROMORIG \
        && echo "creating symlink from $vBASEDIR/liquidprompt/.liquidpromptrc to $vLIQPROMORIG ..." 
}

# finally source .bashrc
. ~/.bashrc && echo "sourcing bashrc ..."
