# -----------------------------------------------------------------------------
# ~zozo/.config/bash/bashrc.d/aliases
# -----------------------------------------------------------------------------

alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

alias bell='tput bel'
alias bye='exit'
alias e='echo'
alias svim='sudo vim'
alias unmount='umount'

alias ttest="${dir_scripts}/dev/test.sh"

# check network connection
alias pingg='ping -c 4 google.com'
# share $PWD at localhost:7777
alias webshare='python -m SimpleHTTPServer 7777'

# chmod
alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 700='chmod 700'
alias 755='chmod 755'

# files/directories
alias disks='df -h'                 # all mounted disks (w/ human units)
alias dirsize='du -sh'              # total size of $PWD
alias sizes='du -sh * | sort -rh'   # sort files & directories in $PWD by size

# ssh
alias m='newwin --title Minerva ssh Minerva'
alias mr='newwin --title Minerva ssh Minerva.remote'
alias er='newwin --title Erato ssh Erato'
alias wf='newwin --title WebFaction ssh WebFaction'

# alias foo='~/scripts/foo.sh'
if [[ -d $dir_scripts ]]; then
    for script in $dir_scripts/*.sh; do
        name=${script##*/}
        name=${name%.sh}

        if ! _isAlias "$name"; then
            alias "$name"="$script"
        fi

        unset -v name script
    done
fi

