# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/aliases
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

alias hd='hexdump -C'

alias etest='_edit "$dir_scripts/dev/test.sh"'
alias ttest="$dir_scripts/dev/test.sh"

alias pinback='"$HOME/scripts/pinback.sh" -t "$pinboard_api_key" -d "$HOME/Archive/pinboard" -fvx'

# -----------------------------------------------------------------------------

# files/directories
alias dirsize='du -sh'              # total size of $PWD
alias sizes='dirsize | sort -rh'    # sort files & directories in $PWD by size

# check network connection
alias pingg='ping -c 4 google.com'

# share $PWD at localhost:17777 (port reserved by IANA)
alias webshare='python -m SimpleHTTPServer 17777'

# get external IP address
alias myip='dig +short @resolver1.opendns.com myip.opendns.com'

# start servers
alias mm='bundle exec middleman'
alias gulp='./node_modules/.bin/gulp'

# chmod
alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 700='chmod 700'
alias 755='chmod 755'

# ssh
alias  a='newwin --title Athena ssh Athena'
alias aa='newwin --title Athena ssh Athena.remote'
alias m='newwin  --title Minerva ssh Minerva'
alias er='newwin --title Erato ssh Erato'
alias wf='newwin --title WebFaction ssh WebFaction'
alias hiroko='newwin --title Hiroko ssh Hiroko'
