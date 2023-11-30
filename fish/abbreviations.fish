# -----------------------------------------------------------------------------
# aliases & abbreviations
# -----------------------------------------------------------------------------

# quick navigation

if fish-is-older-than 3.6
    abbr -a -g .. cd ..
    abbr -a -g ... cd ../..
    abbr -a -g .... cd ../../..
    abbr -a -g ..... cd ../../../..
else
    # https://github.com/fish-shell/fish-shell/releases/tag/3.6.0
    function __cd_dotdot
        echo -n cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end

    abbr --add dotdot --regex '^\.\.+$' --function __cd_dotdot
end

# https://fishshell.com/docs/current/faq.html#faq-cd-minus
abbr -a -g -- '-' 'cd -'

# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

abbr -a -g dr 'defaults read'
abbr -a -g dw 'defaults write'
in-path fd; and abbr -a -g fdd 'fd -td'
in-path fd; and abbr -a -g fdf 'fd -tf'
abbr -a -g r reveal
abbr -a -g s 'set -S'
abbr -a -g ssc 'sudo systemctl'
abbr -a -g svim 'sudo -E vim'
abbr -a -g restow 'stow --restow'
abbr -a -g unset 'set --erase'
abbr -a -g unstow 'stow --delete'

if in-path hexyl
    abbr -a -g xd hexyl
else if in-path xxd
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

# Homebrew
if in-path brew
    abbr -a -g br 'brew'
    abbr -a -g brins 'brew install'
    abbr -a -g brrm 'brew uninstall'
    abbr -a -g brinf 'brew info'
    abbr -a -g brs 'brew search'
    abbr -a -g brcav 'brew caveats'
    abbr -a -g bro 'brew outdated'
    abbr -a -g bru 'brew update'
    abbr -a -g brup 'brew upgrade'
end

# apt
if in-path apt
    abbr -a -g aptins 'sudo apt install'
    abbr -a -g aptinf 'apt show'
    abbr -a -g apts 'apt search'
    abbr -a -g aptup 'sudo apt update && sudo apt upgrade'
end

# ssh
abbr -a -g vshraya 'ssh vshraya'
abbr -a -g opal 'ssh opalstack'
abbr -a -g p.p 'ssh phosphor.pink'
