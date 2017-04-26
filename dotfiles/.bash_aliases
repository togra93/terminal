# author: togra93
# last modification: 2017-04-26
# custom aliases, depending on current host

# global
# general
vCOL="--color=auto"
alias cd..='cd ..'
alias cd2.='cd ../..'
alias cd3.='cd ../../..'
alias egrep="egrep $vCOL"
alias fgrep="fgrep $vCOL"
alias grep="grep $vCOL"
alias ls="ls $vCOL"
alias la="ls -al"
alias ll="ls -l"
alias vi="vim"
alias hg="history | grep"
alias upgrep="pgrep -u $(whoami) -la"
alias backup="cp "$1"{,.bak}"
alias dusort="du ./.[!.]* ./* -k --max-depth=0 | sort -n"

# application specific
[ -e /usr/bin/libreoffice ] && alias doc2pdf='libreoffice --headless --convert-to pdf'

# fun
alias busy="cat /dev/urandom | hexdump -C | grep \"ca fe\""

# work
[ $HOME = "/u/g/grau" ] && {
    alias cdberichtsheft="cd ~/pc/Dokumente/berichtsheft/$(date +%Y)"
    alias cdexchange='cd /m/scratch/itwm/0_EXCHANGE/'
    alias cdslgdoc='cd /p/slg/Dokumente'
    alias lpra4='lpr -U grau -P cpsg0a -o media=A4'
    alias tuncups='ssh -fND 54322 grau@cups'
    alias tunlnx='ssh -fND 54321 grau@lnxmgmt'
    alias wts='xfreerdp --sec rdp -g 1915x1155 -T wts001it wts001it &'
    alias rdp='xfreerdp --sec rdp -g 1024x768'
    alias dellrma='cat ~/pc/Dokumente/dell/rma_help.txt'
}

# vserver


# laptop
