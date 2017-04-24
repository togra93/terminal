# author: togra93
# last updated: 2017-04-19
# configure shell, using given files
# basically backup old ones and create symlinks

vBASEDIR=$(pwd | sed s#"/bin$"##)
vBINDIR=~/bin
vGITDIR=~/git

# set true, if you want to check and even clone the liquidprompt setup
vLIQPROM=false
vLIQPROMLINK="https://github.com/nojhan/liquidprompt.git"

# sync dotfiles
rsync -rb --suffix=".bak" $vBASEDIR/dotfiles/ ~

# sync binaries
rsync -rb --suffix=".bak" --exclude="$(basename $0)" $vBASEDIR/bin $vBINDIR

# check terminator config
# need to write function to query installed software on multiple distros first

# optional: clone/setup liquidprompt
($vLIQPROM) && {
    if [[ $PROMPT_COMMAND != "_lp_set_prompt" ]];then
        if [ -d $vGITDIR/liquidprompt ]; then
            echo "--- ERROR: Directory $vGITDIR/liquidprompt already exists,"
            echo "--- although I couldn't find active Liquidprompt ..."
            echo -e "--- Aborting. Please check configuration!\n" 
            exit 1
        else
            [ ! -d $vGITDIR ] && mkdir $vGITDIR
            git clone -q $vLIQPROMLINK $vGITDIR/liquidprompt
        fi
    fi
    rsync -b --suffix=".bak" $vBASEDIR/liquidprompt/.liquidpromptrc ~
}

echo -e "--- Process finished ..."
echo -e "--- Please run the following command once \e[32msource ~/.bashrc\e[0m\n"
