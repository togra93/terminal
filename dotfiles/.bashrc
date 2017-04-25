# author: togra93
# last modification: 2017-03-31
# this is my own .bashrc, customized to my personal needs

USER_PATHS=~/bin # add paths with leading colon
USER_FILES=(~/.bash_aliases ~/.bash_functions) # add files with leading space
LPDIR=~/git/liquidprompt
IFS_ORIG=$IFS

# source global definitions
[ -e /etc/bashrc ] && . /etc/bashrc

# source user specific aliases, functions and other files
for i in ${USER_FILES[@]};do
    [ -e $i ] && . $i
done

# export user specific paths (e.g. for own binaries, ...)
IFS=$':'
for i in $USER_PATHS;do
    [ -d $i ] && export PATH=$PATH:$i
done
IFS=$IFS_ORIG

# only in interactive shells
case $- in
    *i*)
    # set dircolors 
    [ -e ~/.dir_colors ] && eval `dircolors ~/.dir_colors` 
    # load liquid prompt
    [ -d $LPDIR ] && . ${LPDIR}/liquidprompt && source ~/.liquidpromptrc
    # fancy man pages
    export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode – red
    export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode – bold, magenta
    export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
    export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode
    export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode – yellow
    export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
    export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode – cyan  
esac
