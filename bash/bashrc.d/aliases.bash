# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/aliases
# -----------------------------------------------------------------------------

alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

alias bell='tput bel' # 🔔
alias bye='exit'
alias d='declare -p'
alias e='printf "%s\n"'
alias i='newwin irb'
alias svim='sudo XDG_DATA_HOME="$XDG_DATA_HOME" vim'
alias unmount='umount'
alias vd='newwin vimdiff'
alias which='builtin type'

alias builtins='compgen -b | column'
alias functions='compgen -A function | column'

alias c='pbcopy'
alias p='pbpaste'

alias hd='hexdump -C'

alias  etest='_z_edit "$dir_dropbox/src/test.sh"'
alias  ttest="$dir_dropbox/src/test.sh"
export rtest="$dir_dropbox/src/test.rb"
alias  rtest="$rtest"

alias pinback='"$HOME/scripts/pinback.sh" -t "$PINBOARD_API_KEY" \
                                          -d "$HOME/Archive/pinboard" -fvx'

# -----------------------------------------------------------------------------

# share $PWD at localhost:17777 (port reserved by IANA)
alias webshare='python -m SimpleHTTPServer 17777'

# get external IP address
alias myip='dig +short @resolver1.opendns.com myip.opendns.com'

# start servers
if [[ $HOSTNAME == Athena* ]]; then
  alias mm='bundle exec middleman'
fi

# chmod
alias 400='chmod -v 400'
alias 600='chmod -v 600'
alias 644='chmod -v 644'
alias 700='chmod -v 700'
alias 755='chmod -v 755'
