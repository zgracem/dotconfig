# -----------------------------------------------------------------------------
# aliases & abbreviations
# -----------------------------------------------------------------------------

# quick navigation

function ..; cd .. ; end
function ...; cd ../.. ; end
function ....; cd ../../.. ; end
function .....; cd ../../../.. ; end

# https://fishshell.com/docs/current/faq.html#faq-cd-minus
abbr --add --global -- '-' 'cd -'

# macOS & misc.

if macos?
  function airport --description 'Get information for 802.11 interface'; /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport $argv; end
  function lockscreen; /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend; end
  function lsregister --description 'Manage the Launch Services database'; /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister $argv; end
end

if string match -eq 'Athena' $hostname
  function vsdeploy; "$HOME/Dropbox/www/vs2017/bin/sync.sh" $argv; end
end

function bye --description 'Exit the shell'; kill %self; end
function e --description 'Print each argument to a new line'; printf "%s\\n" $argv; end
function l --wraps less; less --quit-if-one-screen $argv; end

# ssh

function athena
  if string match -eq '.local' $hostname
    _ssh Athena.local
  else
    _ssh Athena.remote
  end
end

function vshraya; _ssh vshraya; end
function wf; _ssh WebFaction; end

# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

if macos?
  abbr --add --global plistbuddy '/usr/libexec/PlistBuddy'
  abbr --add --global sp 'mdfind -name'
end

abbr --add --global fkr 'fish_key_reader --continuous'

abbr --add --global dirsize 'du -sh'
abbr --add --global unset 'set --erase'
abbr --add --global unstow 'stow --delete'
abbr --add --global xd 'hexdump -C'
abbr --add --global wtf 'type'

in-path bundle; and in-path middleman;
  and abbr --add --global mm 'bundle exec middleman'

if in-path wget
  abbr --add --global dl 'wget'
else if in-path curl
  abbr --add --global dl 'curl -OJ'
end

# git

abbr --add --global gb  git branch
abbr --add --global gc  git commit
abbr --add --global gco git checkout
abbr --add --global gf  git fetch
abbr --add --global gp  git push
abbr --add --global gpl git pull
