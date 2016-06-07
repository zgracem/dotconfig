# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/aliases
# -----------------------------------------------------------------------------

alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

alias bell='tput bel' # 🔔
alias bye='exit'
alias e='echo'
alias svim='sudo vim'
alias unmount='umount'

alias c='pbcopy'
alias p='pbpaste'

alias d='declare -p'

alias hd='hexdump -C'

alias etest='_edit "$dir_dropbox/src/test.sh"'
alias stest='. "$dir_dropbox/src/test.bash"'
alias ttest="$dir_dropbox/src/test.sh"

alias pinback='"$HOME/scripts/pinback.sh" -t "$PINBOARD_API_KEY" -d "$HOME/Archive/pinboard" -fvx'

# -----------------------------------------------------------------------------

# files/directories
alias dirsize='du -sh .'            # total size of $PWD
alias sizes='dirsize | sort -rh'    # sort files & directories in $PWD by size

# check network connection
alias pingg='ping -c 4 google.com'

# share $PWD at localhost:17777 (port reserved by IANA)
alias webshare='python -m SimpleHTTPServer 17777'

# get external IP address
alias myip='dig +short @resolver1.opendns.com myip.opendns.com'

# start servers
alias mm='bundle exec middleman'

# chmod
alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 700='chmod 700'
alias 755='chmod 755'
