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

abbr -a -g dr 'defaults read'
abbr -a -g dw 'defaults write'
in-path fd; and abbr -a -g fdd 'fd -td'
in-path fd; and abbr -a -g fdf 'fd -tf'
abbr -a -g r reveal
abbr -a -g s 'set -S'
abbr -a -g size 'du -sh'
abbr -a -g ssc 'sudo systemctl'
abbr -a -g restow 'stow --restow'
abbr -a -g unset 'set --erase'
abbr -a -g unstow 'stow --delete'

if in-path hexyl
    abbr -a -g xd hexyl
else
    abbr -a -g xd 'xxd -u -g1'
end

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

# Homebrew
abbr -a -g bi 'brew install'
abbr -a -g ci 'brew install --cask'
abbr -a -g bu 'brew uninstall'
abbr -a -g cu 'brew uninstall --cask'
abbr -a -g binf 'brew info'
abbr -a -g bs 'brew search'
abbr -a -g bcav 'brew caveats'
