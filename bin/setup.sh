#!/bin/bash
# author: togra93
# last updated: 2017-04-24
# configure shell, using given files
# basically backup old ones and create symlinks

vBASEDIR=$(pwd | sed s#"/bin$"##)
vBINDIR=~/bin
vGITDIR=~/git
vLIQPROM=false
vLIQPROMLINK="https://github.com/nojhan/liquidprompt.git"
vTERMINATOR=false

# query options liquidprompt/terminator
vOPTS='lth'
if [ ! -z $1 ]; then
    while getopts "$vOPTS" opt;do
        case ${opt} in
            l ) vLIQPROM=true;;
            t ) vTERMINATOR=true;;
            * ) help();;
        esac
    done
fi

# help
help ()
{
cat<<EOF
Configure Shell/Terminal
(dotfiles, binaries, extra packages)
Usage: $(basename $0) [-l] [-t]

Options:
    -h          Display this help message
    -l          Set up Liquidprompt
    -t          Set up Terminator
EOF
exit
}

# information
clear
echo "--------------------------------------"
echo "--- Setting up your Shell/Terminal ---"
echo "--------------------------------------"
echo -e "\nAlready existing files will be moved to <FILE>.bak."
read -p "Do you want to run this script (y/n)?" answer
case ${answer:0:1} in
    y|Y )
        echo "Starting Script ...";;
    n|N )
        echo "Aborting ...";exit;;
    * )
        echo "Input not valid ...";exit;;
esac

# sync dotfiles
rsync -rb --suffix=".bak" $vBASEDIR/dotfiles/ ~ && echo -e "--- INFO: Copying dotfles successful.\n"

# sync binaries
[ ! -d $vBINDIR ] && mkdir $vBINDIR && echo "--- INFO: Creating directory $vBINDIR."
rsync -rb --suffix=".bak" --exclude="$(basename $0)" $vBASEDIR/bin/* $vBINDIR && \
    echo -e "--- INFO: Copying binaries successful.\n"

# check terminator config
# need to write function to query installed software on multiple distros first
($vTERMINATOR) && {

}

# clone/setup liquidprompt
($vLIQPROM) && {
    if [ -d $vGITDIR ];then
    {
        if [ -d $vGITDIR/liquidprompt ];then
        {
            echo "--- INFO: Directory $vGITDIR/liquidprompt already exists."
            echo -e "--- Not cloning into repository.\n"
        }
        else git clone -q $vLIQPROMLINK $vGITDIR/liquidprompt && \
            echo -e "--- INFO: Successfully cloned into liquidprompt!\n"
        fi
    }
    else
    {
        [ ! -d $vGITDIR ] && mkdir $vGITDIR
        git clone -q $vLIQPROMLINK $vGITDIR/liquidprompt && \
            echo -e "--- INFO: Successfully cloned into liquidprompt!\n"
    }
    fi
    rsync -b --suffix=".bak" $vBASEDIR/liquidprompt/.liquidpromptrc ~
}


echo "--- Setting up your Terminal is now finished."
echo -e "--- Please run the following command once \e[32msource ~/.bashrc\e[0m"
