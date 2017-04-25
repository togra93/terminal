#!/bin/bash
# author: togra93
# last modification: 2017-04-25
# customized functions to facilitate my life

# extract files
function extract()
{
     if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   
                tar xvjf $1;;
            *.tar.gz)    
                tar xvzf $1;;
            *.bz2)       
                bunzip2 $1;;
            *.rar)
                unrar x $1;;
            *.gz)
                gunzip $1;;
            *.tar)
                tar xvf $1;;
            *.tbz2)
                tar xvjf $1;;
            *.tgz)
                tar xvzf $1;;
            *.zip)
                unzip $1;;
            *.Z)
                uncompress $1;;
            *.7z)
                7z x $1;;
            *)  
                echo "'$1' cannot be extracted via extract";;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# make directory and move into it
function mcd ()
{
    mkdir -p $1
    cd $1
}

function tree()
{
    ls -R | grep ":$" \
        | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}

# same working experience on different distributions

#...
