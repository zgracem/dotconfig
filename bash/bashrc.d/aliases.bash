# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/aliases
# -----------------------------------------------------------------------------

alias    ..='cd ..'
alias   ...='cd ../..'
alias  ....='cd ../../..'
alias .....='cd ../../../..'

alias bye='exit'
alias d='declare -p'
alias i='newwin irb -rzgm/irb'
alias vimsudo='sudo XDG_DATA_HOME="$XDG_DATA_HOME" vim'
alias which='builtin type'
alias xd='hexdump -C'

alias  etest='_z_edit "$dir_dropbox/src/test.sh"'
alias  ttest='"$dir_dropbox/src/test.sh"'
alias  rtest='"$rtest"'
# The use of single & double quotes here is deliberate
# shellcheck disable=SC2016
export rtest='"$dir_dropbox/src/ruby/_scratch/_test.rb"'

# -----------------------------------------------------------------------------

# start servers
if _inPath bundle && _inPath middleman; then
  alias mm='bundle exec middleman'
fi

if _inPath bundle && _inPath jekyll; then
  alias jj='bundle exec jekyll'
fi

# chmod
alias 400='chmod -v 400'
alias 600='chmod -v 600'
alias 644='chmod -v 644'
alias 700='chmod -v 700'
alias 755='chmod -v 755'
