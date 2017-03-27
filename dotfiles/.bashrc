# author: togra93
# last modification: 2017-03-14
# this is my own .bashrc, customized to my personal needs

USER_PATHS=~/bin/ # add paths with leading colon
USER_FILES=(~/.bash_aliases ~/.bash_functions) # add files with leading space
LPDIR=~/git/liquidprompt/
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
    [ -d $LPDIR ] && . ${LPDIR}liquidprompt && source ~/.liquidpromptrc
esac
