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

# ssh

if string match -q '*.local' $hostname
  abbr -a -g citadel '_ssh Citadel.local'
  abbr -a -g erato '_ssh Erato'
else
  abbr -a -g citadel '_ssh Citadel.remote'
end

abbr -a -g vshraya '_ssh vshraya'
abbr -a -g wf '_ssh WebFaction'

# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

if is-macos
  abbr -a -g plbuddy '/usr/libexec/PlistBuddy'
  abbr -a -g sp 'mdfind -name'
end

abbr -a -g bye 'exit'
abbr -a -g dirsize 'du -sh'
abbr -a -g unset 'set --erase'
abbr -a -g unstow 'stow --delete'
abbr -a -g wtf 'type'
abbr -a -g xd 'hexdump -C'
abbr -a -g ydl 'youtube-dl'

abbr -a -g 555 'chmod 0555'
abbr -a -g 600 'chmod 0600'
abbr -a -g 644 'chmod 0644'
abbr -a -g 700 'chmod 0700'
abbr -a -g 755 'chmod 0755'

if in-path bundle; and in-path middleman
  abbr -a -g mm 'bundle exec middleman'
  abbr -a -g mmn 'bundle exec middleman 2>/dev/null'
end

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
