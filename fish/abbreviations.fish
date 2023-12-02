# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

# quick navigation
if fish-is-older-than 3.6
    abbr -a .. cd ..
    abbr -a ... cd ../..
    abbr -a .... cd ../../..
    abbr -a ..... cd ../../../..
else
    # https://github.com/fish-shell/fish-shell/releases/tag/3.6.0
    function __cd_dotdot
        echo -n cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end

    abbr --add dotdot --regex '^\.\.+$' --function __cd_dotdot
end

# https://fishshell.com/docs/current/faq.html#faq-cd-minus
abbr -a -- '-' 'cd -'

# -----------------------------------------------------------------------------
# shortcuts
# -----------------------------------------------------------------------------

abbr -a dr 'defaults read'
abbr -a dw 'defaults write'
in-path fd; and abbr -a fdd 'fd -td'
in-path fd; and abbr -a fdf 'fd -tf'
abbr -a r reveal
abbr -a s 'set -S'
abbr -a ssc 'sudo systemctl'
abbr -a svim 'sudo -E vim'
abbr -a restow 'stow --restow'
abbr -a unset 'set --erase'
abbr -a unstow 'stow --delete'

if in-path hexyl
    abbr -a xd hexyl
else if in-path xxd
    abbr -a xd 'xxd -u -g1'
end

abbr -a 'ux' 'chmod u+x'
abbr -a 'gorx' 'chmod go+rx'

if in-path wget
    abbr -a dl wget
else if in-path curl
    abbr -a dl 'curl -OJ'
end

# Homebrew
if in-path brew
    abbr -a br 'brew'
    abbr -a brins 'brew install'
    abbr -a brrm 'brew uninstall'
    abbr -a brinf 'brew info'
    abbr -a brs 'brew search'
    abbr -a brcav 'brew caveats'
    abbr -a bro 'brew outdated'
    abbr -a bru 'brew update'
    abbr -a brup 'brew upgrade'
end

# apt
if in-path apt
    abbr -a aptins 'sudo apt install'
    abbr -a aptinf 'apt show'
    abbr -a apts 'apt search'
    abbr -a aptup 'sudo apt update && sudo apt upgrade'
end

# ssh
abbr -a vshraya 'ssh vshraya'
abbr -a opal 'ssh opalstack'
abbr -a p.p 'ssh phosphor.pink'
