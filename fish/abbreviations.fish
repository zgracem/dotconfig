# -----------------------------------------------------------------------------
# aliases & abbreviations
# -----------------------------------------------------------------------------

# quick navigation

abbr -a -g .. cd ..
abbr -a -g ... cd ../..
abbr -a -g .... cd ../../..
abbr -a -g ..... cd ../../../..

# https://fishshell.com/docs/current/faq.html#faq-cd-minus
abbr -a -g -- '-' 'cd -'

# ssh

abbr -a -g vshraya 'sfish vshraya'
abbr -a -g opal 'sfish opalstack'

# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

abbr -a -g dirsize 'du -sh'
abbr -a -g dr 'defaults read'
abbr -a -g fdd 'fd --type d'
abbr -a -g s 'set -S'
abbr -a -g unstow 'stow --delete'
abbr -a -g xd 'hexyl --border=none'

abbr -a -g 555 'chmod 0555'
abbr -a -g 600 'chmod 0600'
abbr -a -g 644 'chmod 0644'
abbr -a -g 700 'chmod 0700'
abbr -a -g 755 'chmod 0755'

if in-path wget
    abbr -a -g dl wget
else if in-path curl
    abbr -a -g dl 'curl -OJ'
end

# git
abbr -a -g gc 'git checkout -b'
