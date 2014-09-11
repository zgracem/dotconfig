# -----------------------------------------------------------------------------
# ~zozo/.config/bash/aliases
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# get info
# -----------------------------------------------------------------------------

# files/directories
alias cds='dirs -v'                 # directory stack w/ positions
alias cppwd='printf "%q" "$PWD" | pbcopy'   # copy $PWD to clipboard
alias dirsize='du -sh'              # total size of $PWD
alias disks='df -h'                 # all mounted disks (w/ human units)
alias sizes='du -sh * | sort -rh'   # sort files & directories in $PWD by size

# display/search all variable values & attributes
alias vars="declare -p | colourstrip | sed -nE 's/^declare (.*)$/\1/p' | sort -k2"
alias allvars='vars | command less'
alias vgrep='vars | grep -i'

# -----------------------------------------------------------------------------
# fixes
# -----------------------------------------------------------------------------

if [[ $OSTYPE =~ darwin ]] && _isGNU mv; then
    # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    alias mv="/bin/mv $flags_mv"
fi

# -----------------------------------------------------------------------------
# shortcuts
# -----------------------------------------------------------------------------

# lazy
alias btadd='transmission-remote --add'
alias bye='exit'
alias e='echo'
alias psi='python setup.py install'
alias svim='sudo vim'
alias unmount='umount'
alias wv='map whatvar:'             # see functions/{debug,zhelp}.bash
alias yegw='weather edmonton'

# ls
alias ll='ls -lgoh'                 # long, omit group & owner, human sizes
alias ls1='command ls -A1'          # just the filenames
alias lst='ll -rt'                  # newest files last

# git
alias gc='git commit'
alias gd='git difftool'

# screen & tmux
alias ss='screen -d -R '
alias tt='tmux attach 2>&- || tmux -2 new-session'

# open in a new window if tmux/GNU screen is running (see functions/newwin.bash)
alias alpine="newwin alpine $flags_alpine"
alias bt="newwin --title transmission $dir_mybin/github/transmission-remote-cli/transmission-remote-cli"
alias l='newwin less'
alias profanity='newwin profanity --account gtalk'
alias twitter='newwin ttytter'
alias vim='newwin vim'

# misc.
alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

alias bell='tput bel'
alias colourstrip='sed -E "s|\[[0-9;]*m?||g"'
alias dl='curl -OJ'                 # download a file
alias headers='curl -Is'            # HTTP headers for $1
alias myip='curl -S $ip_site'       # external IP address (see private.bash)
alias nowz='date --utc +%FT%TZ'     # date & time in ISO 8601 format
alias pingg='ping -c 4 google.com'  # check network connection
alias sortpb='pbpaste | sort -u | pbcopy'

alias newpw="$dir_scripts/newpassword.sh -c"
alias newpwclip="newpw | colourstrip | tr -d '\n' | pbcopy"
alias ttest="$dir_scripts/dev/test.sh"

# alias foo='~/scripts/foo.sh'
[[ -d $dir_scripts ]] && {
    for script in $dir_scripts/*.sh; do
        name=${script##*/}
        alias "${name%.sh}"="$script"
    done
    unset name script
}

# ~/bin
alias jsawk="$dir_mybin/github/jsawk/jsawk"
alias twee="$dir_mybin/github/twine/twee"
alias untwee="$dir_mybin/github/twine/untwee"

# chmod
for mode in 400 600 644 700 755; do
    alias "$mode"="chmod $mode" && unset mode
done

# -----------------------------------------------------------------------------
# ssh (user/hostname settings in ~/.ssh/config)
# -----------------------------------------------------------------------------

alias m='newwin --title Minerva ssh Minerva'
alias er='newwin --title Erato ssh Erato'
alias mh='newwin --title Minerva ssh Minerva.remote'
alias dh='newwin --title Dreamhost ssh Dreamhost'
alias wf='newwin --title WebFaction ssh WebFaction'

alias dproxy='ssh -fCqND 8080 Dreamhost'
alias mproxy='ssh -fCqND 8080 Minerva.remote'
alias wfproxy='ssh -fCqND 8080 WebFaction'

# -f = go to background     -C = compress all data
# -q = quiet mode           -N = don't exec remote command (fwd only)
# -D 8080 = dynamic port forwarding on 8080
