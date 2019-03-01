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
  alias airport '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
  alias dnsflush 'sudo dscacheutil -flushcache; and sudo killall -HUP mDNSResponder'
  alias lockscreen '/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
  alias lsregister '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
  alias plistbuddy '/usr/libexec/PlistBuddy'
  alias spotlight 'mdfind -name'
  abbr --add --global sp spotlight
end

if string match -eq 'Athena' $hostname
  alias vsdeploy "$HOME/Dropbox/www/vs2017/bin/sync.sh"
end

alias bye 'kill %self'
alias e 'printf "%s\\n"'
alias i 'irb -rzgm/irb'
alias l 'less --quit-if-one-screen'
alias s 'subl --add'

abbr --add --global unset 'set --erase'
abbr --add --global unstow 'stow --delete'
abbr --add --global xd 'hexdump -C'
abbr --add --global wtf 'type'

in-path bundle; and in-path middleman;
  and abbr --add --global mm 'bundle exec middleman'

in-path vimdiff; or alias vimdiff 'vim -d'

# git
abbr --add --global gb  git branch
abbr --add --global gc  git commit
abbr --add --global gco git checkout
abbr --add --global gf  git fetch
abbr --add --global gp  git push
abbr --add --global gpl git pull

# ssh
if string match -eq '.local' $hostname
  alias athena '_ssh Athena.local'
else
  alias athena '_ssh Athena.remote'
end
alias vshraya '_ssh vshraya'
alias wf '_ssh WebFaction'
