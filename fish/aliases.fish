# -----------------------------------------------------------------------------
# quick navigation
# -----------------------------------------------------------------------------

function ..; cd .. ; end
function ...; cd ../.. ; end
function ....; cd ../../.. ; end
function .....; cd ../../../.. ; end

# https://fishshell.com/docs/current/faq.html#faq-cd-minus
abbr --add --global -- '-' 'cd -'

# -----------------------------------------------------------------------------
# macOS & misc.
# -----------------------------------------------------------------------------

if macos?
  alias dnsflush 'sudo dscacheutil -flushcache; and sudo killall -HUP mDNSResponder'
  alias PlistBuddy '/usr/libexec/PlistBuddy'
  alias spotlight 'mdfind -name'
  abbr --add --global sp spotlight
end

if uname -n | string match -eq "Athena"
  alias vsdeploy "$HOME/Dropbox/www/vs2017/bin/sync.sh"
end

alias bye 'kill %self'
alias e 'printf "%s\n"'
alias i 'irb -rzgm/irb'
alias l 'less --quit-if-one-screen'
alias s 'subl --add'
alias tt 'tmux new-session -A -s main'
alias unset 'set --erase'
alias unstow 'stow --delete'
abbr --add --global wtf 'type'

in-path vimdiff; or alias vimdiff 'vim -d'

in-path bundle; and in-path middleman; and alias mm 'bundle exec middleman'

# git
abbr --add --global gb  git branch
abbr --add --global gco git checkout
abbr --add --global gp  git push
abbr --add --global gpl git pull
abbr --add --global gf  git fetch

# ssh
alias vshraya 'ssh vshraya'
alias wf 'ssh WebFaction'

if string match -eq .local $hostname
  alias athena 'ssh Athena.local'
else
  alias athena 'ssh Athena.remote'
end

# -----------------------------------------------------------------------------
# cp, mv, rm -- make interactive and verbose
# -----------------------------------------------------------------------------

alias cp 'command cp -aiv'

if is-gnu rm
  alias rm 'command rm -Iv'
else
  alias rm 'command rm -iv'
end

if macos?
  # >> http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
  alias mv '/bin/mv -iv'
else
  alias mv 'command mv -iv'
end

# -----------------------------------------------------------------------------
# misc., mostly verbosity
# -----------------------------------------------------------------------------

alias chmod 'command chmod -v'
alias dtrx 'command dtrx --verbose'
alias killall 'command killall -v'
alias ln 'command ln -v'
alias mkdir 'command mkdir -pv'
alias rename 'command rename --verbose'
alias stow 'command stow --verbose'
