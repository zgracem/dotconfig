# -----------------------------------------------------------------------------
# ~zozo/.config/bash/aliases
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# Get info
# -----------------------------------------------------------------------------

# files/directories
alias cppwd='printf "%q" "$PWD" | pbcopy'   # copy $PWD to clipboard
alias dirsize="du -sh"              # total size of $PWD
alias disks="df -h"                 # all mounted disks (w/ human units)
alias sizes="du -s ./* | sort -rn"  # sort files & directories in $PWD by size

# display/search all variable values & attributes
alias vars="declare -p | colourstrip | sed -nE 's/^declare (.*)$/\1/p' | sort -k2"
alias allvars="vars | command less"
alias vgrep="vars | grep -i"

# history sorted by frequency of use
alias tophist="history | awk '{print \$4}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# -----------------------------------------------------------------------------
# Shortcuts
# -----------------------------------------------------------------------------

# lazy
alias btadd='transmission-remote --add'
alias e="echo"
alias psi="python setup.py install"
alias qpb='_pb="$(pbpaste)";echo "[[ $_pb ]]";q "$_pb";unset _pb'
alias s="screen -d -R "
alias svim="sudo vim"
alias t="tmux attach 2>&- || tmux -2 new-session"

# open in a new window if tmux/GNU screen is running (see functions/newwin.bash)
alias alpine="newwin alpine $flags_alpine"
alias bt="newwin --title transmission $dir_mybin/transmission-remote-cli/transmission-remote-cli"
alias l='newwin less'
alias twitter="newwin ttytter"
alias vim='newwin vim'

# misc.
alias colourstrip='sed -E "s/"$'\E'"\[([0-9]{1,2}(;[0-9]{1,2})*)?m//g"'
alias cronedit="crontab -e"
alias dl="curl -OJ"                 # download a file
alias headers="curl -Is"            # HTTP headers for $1
alias ls1="command ls -A1"          # just the filenames
alias myip='curl -S $ip_site'       # external IP address (see private.bash)
alias pingg="ping -c 4 google.com"  # check network connection
alias unmount="umount"

alias newpw="$dir_scripts/newpassword.sh -l 16 -d 4-6 -s 3-5 -bc"
alias pwclip="newpw | colourstrip | tr -d '\n' | pbcopy"
alias ttest="$dir_scripts/dev/test.sh"

# alias foo='~/scripts/foo.sh'
[[ -d $dir_scripts ]] && {
    for script in $dir_scripts/*.sh; do
        name=${script##*/}
        alias "${name%.sh}"="$script"
    done
    unset name script
}

# chmod
for mode in 400 600 644 700 755; do
    alias "$mode"="chmod $mode" && unset mode
done

# ssh (user/hostname settings in ~/.ssh/config)
alias m="newwin --title Minerva ssh Minerva"
alias er="newwin --title Erato ssh Erato"
alias dh="newwin --title Dreamhost ssh Dreamhost"
alias mh="newwin --title Minerva ssh Minerva.remote"

alias dproxy="ssh -fCqND 8080 Dreamhost"
alias mproxy="ssh -fCqND 8080 Minerva.remote"

# -f = go to background     -C = compress all data
# -q = quiet mode           -N = don't exec remote command (fwd only)
# -D 8080 = dynamic port forwarding on 8080
