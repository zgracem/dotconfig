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

if is-macos
  function airport --description 'Get information for 802.11 interface'
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport $argv
  end

  function firefox --description 'Launch Mozilla Firefox'
    open -b org.mozilla.firefox $argv
  end

  function lockscreen --description 'Lock the screen'
    /System/Library/CoreServices/'Menu Extras'/User.menu/Contents/Resources/CGSession -suspend
  end

  function lsregister --description 'Manage the Launch Services database'
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister $argv
  end

  function lscleanup --description 'Clean up the Launch Services database'
    lsregister -v -kill -r -domain local,system,user
    and killall Finder
  end
end

if string match -eq 'Athena' $hostname
  function vsdeploy --description 'Deploy vivekshraya.com'
    ~/Dropbox/www/vs2017/bin/sync.sh $argv
  end
end

# ssh

if string match -eq '.local' $hostname
  function athena; _ssh Athena.local; end
else
  function athena; _ssh Athena.remote; end
end

function erato; _ssh Erato; end
function vshraya; _ssh vshraya; end
function wf; _ssh WebFaction; end

# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

if is-macos
  abbr -a -g plistbuddy '/usr/libexec/PlistBuddy'
  abbr -a -g sp 'mdfind -name'
end

abbr -a -g bye 'exit'
abbr -a -g ef 'funced'
abbr -a -g fkr 'fish_key_reader --continuous'
abbr -a -g unset 'set --erase'
abbr -a -g wtf 'type'

abbr -a -g dirsize 'du -sh'
abbr -a -g unstow 'stow --delete'
abbr -a -g xd 'hexdump -C'
abbr -a -g ydl 'youtube-dl'

abbr -a -g 555 'chmod 0555'
abbr -a -g 600 'chmod 0600'
abbr -a -g 644 'chmod 0644'
abbr -a -g 700 'chmod 0700'
abbr -a -g 755 'chmod 0755'

in-path bundle; and in-path middleman;
  and abbr -a -g mm 'bundle exec middleman'

if in-path wget
  abbr -a -g dl 'wget'
else if in-path curl
  abbr -a -g dl 'curl -OJ'
end

# git

abbr -a -g ga  git add
abbr -a -g gb  git branch
abbr -a -g gc  git commit
abbr -a -g gco git checkout
abbr -a -g gf  git fetch
abbr -a -g gp  git push
abbr -a -g gpl git pull
