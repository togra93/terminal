#!/bin/bash
# author: togra93
# last modification: 2017-04-26
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

# use the same commands on multiple distributions to manage packages
# called once in ~/.bashrc
function mypkg()
{
  myapt=false
  myyum=false
  mypacman=false
  myzypper=false

  # determine os and packet manager
  myOS=$(cat /etc/os-release | grep -i "^name=" | sed -r s/"(NAME=|\")"//g | tr '[:upper:]' '[:lower:]')
  [[ "$myOS" =~ .*(redhat|red hat|fedora|centos|cent os).* ]] && myyum=true
  [[ "$myOS" =~ .*(debian|ubuntu).* ]] && myapt=true
  [[ "$myOS" =~ .*arch.* ]] && mypacman=true
  [[ "$myOS" =~ .*suse.* ]] && myzypper=true

  # set aliases
  ($myyum) &&
  {
      alias pkgq="rpm -qa | grep -i"
      alias pkgs="yum search"
      alias pkgi="yum install"
      alias pkgr="yum erase"
      alias pkgu="yum check-update && yum update"
  }
  ($myapt) &&
  {
      alias pkgq="dpkg -l | grep -i"
      alias pkgs="apt-cache search"
      alias pkgi="apt-get install"
      alias pkgr="apt-get remove"
      alias pkgu="apt-get update && apt-get upgrade"
  }
  ($mypacman) &&
  {
      alias pkgq="pacman -Q | grep -i"
      alias pkgs="pacman -Ss"
      alias pkgi="pacman -S"
      alias pkgr="pacman -R"
      alias pkgu="pacman -Sy && pacman -Su"
  }
  ($myzypper) &&
  {
      alias pkgq="zypper search -is | grep -i"
      alias pkgs="zypper search -t pattern"
      alias pkgi="zypper install"
      alias pkgr="zypper remove"
      alias pkgu="zypper refresh && zypper update"
  }
}
