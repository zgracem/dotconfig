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
abbr -a -g dr defaults read
abbr -a -g fdd fd --type d
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

# git
abbr -a -g gc git checkout -b
