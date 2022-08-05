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

abbr -a -g vshraya '_ssh vshraya'
abbr -a -g opal '_ssh opalstack'

# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

abbr -a -g dirsize 'du -sh'
abbr -a -g s 'set -S'
abbr -a -g unstow 'stow --delete'
abbr -a -g xd 'hexdump -C'

abbr -a -g 555 'chmod 0555'
abbr -a -g 600 'chmod 0600'
abbr -a -g 644 'chmod 0644'
abbr -a -g 700 'chmod 0700'
abbr -a -g 755 'chmod 0755'

if command -sq wget
    abbr -a -g dl wget
else if command -sq curl
    abbr -a -g dl 'curl -OJ'
end

if command -sq code
    abbr -a -g vsx "~/.config/bin/vscode-extensions"
end

abbr -a -g sdmods open -a Finder \"$HOME/Library/Application Support/Steam/SteamApps/common/Stardew Valley/Contents/MacOS/Mods\"
abbr -a -g sdsaves open -a Finder \~/.config/StardewValley/Saves

# git

abbr -a -g ga git add
abbr -a -g gb git branch
abbr -a -g gc git commit
abbr -a -g gco git checkout
abbr -a -g gf git fetch
abbr -a -g gp git push
abbr -a -g gpl git pull
