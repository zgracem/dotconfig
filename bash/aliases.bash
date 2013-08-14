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
alias numfiles="ls -1 | wc -l"      # number of files in $PWD
alias sizes="du -s ./* | sort -rn"  # sort files & directories in $PWD by size

# display/search all variable values & attributes
alias vars="declare -p | colourstrip | grep '^declare' | cut -d' ' -f2- | sort -k2"
alias allvars="vars | command less"
alias findvar="vars | grep -i"

# history sorted by frequency of use
alias tophist="history | awk '{print \$4}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# -----------------------------------------------------------------------------
# Shortcuts
# -----------------------------------------------------------------------------

# lazy
alias c="$dir_scripts/countdown.sh '2013-10-01 00:00:00 -0500'"
alias e="echo"
alias psi="python setup.py install"
alias qpb='q "$(pbpaste)"'
alias s="screen -d -R "
alias t="tmux attach 2>&- || tmux -2 new-session"

# open in a new window if GNU screen is running (see functions/newwin.bash)
alias alpine="newwin alpine $flags_alpine"
alias bt="newwin --title transmission $dir_mybin/transmission-remote-cli/transmission-remote-cli"
alias l='newwin less'
alias twitter="newwin --title twitter $dir_mybin/ttytter.pl"
alias vim='newwin vim'

# misc.
alias :wq="exit"
alias cronedit="crontab -e"
alias def="dict -d wn"              # dictionary definition of $1
alias dl="curl -OJ"                 # download a file
alias headers="curl -Is"            # HTTP headers for $1
alias ls1="command ls -A1"          # just the filenames
alias myip="curl -S icanhazip.com"  # external IP address
alias pingg="ping -c 4 google.com"  # check network connection
alias rootme="sudo STY=$STY TMOUT=180 -s"   # logout after 3 min. inactivity
alias unmount="umount"

alias colourstrip="perl -pe 's/\e\[?.*?[\@-~]//g'"
alias newpw="$dir_scripts/newpassword.sh -l 16 -d $(((RANDOM%3)+4)) -s $(((RANDOM%3)+2)) -bc"
alias pwclip="newpw | colourstrip | tr -d '\n' | pbcopy"

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

# ssh (User/HostName settings in ~/.ssh/config)
alias m="ssh Minerva"
alias er="ssh Erato"
alias dh="ssh Dreamhost"
alias mh="ssh Minerva.remote"

alias dproxy="ssh -fCqND 8080 Dreamhost"
alias mproxy="ssh -fCqND 8080 Minerva.remote"

# -f = go to background     -C = compress all data
# -q = quiet mode           -N = don't exec remote command (fwd only)
# -D 8080 = dynamic port forwarding on 8080
