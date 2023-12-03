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

# ----------------------------------------------------------------------------
# default options
# ----------------------------------------------------------------------------

abbr --add file "file -p" # don't touch last-accessed time
abbr --add hexyl "hexyl --border=none"
abbr --add killall "killall -v"
abbr --add ln "ln -v"
abbr --add mkdir "mkdir -pv"
abbr --add rename "rename -v"
abbr --add stow "stow -v"
abbr --add restow "stow -v --restow"
abbr --add unstow "stow -v --delete"
abbr --add xxd "xxd -u -g1" # -u = uppercase; -g1 = 1 octet per group

set -l _chmod_verbose_flag
if is-gnu chmod
    set _chmod_verbose_flag "-c" # show only changes
else
    set _chmod_verbose_flag "-v" # show all operations
end
abbr --add chmod "chmod $_chmod_verbose_flag"
abbr --add "ux" "chmod $_chmod_verbose_flag u+x"
abbr --add "gorx" "chmod $_chmod_verbose_flag go+rx"

if in-path eza
    abbr --add ll "eza -l"
    abbr --add ls "eza"
else
    abbr --add ll "ls -lh"
end

set -l _fd_default_flags "-HLI"
abbr --add fd "fd $_fd_default_flags" # --hidden --follow --no-ignore
abbr --add fdd "fd $_fd_default_flags -td"
abbr --add fdf "fd $_fd_default_flags -tf"

# -----------------------------------------------------------------------------
# shortcuts
# -----------------------------------------------------------------------------

abbr -a dr 'defaults read'
abbr -a dw 'defaults write'
abbr -a r reveal
abbr -a s 'set -S'
abbr -a ssc 'sudo systemctl'
abbr -a svim 'sudo -E vim'
abbr -a unset 'set --erase'

# Homebrew
in-path brew
and abbr -a br "brew"

# apt
if in-path apt
    abbr -a aptins 'sudo apt install'
    abbr -a aptinf 'apt show'
    abbr -a apts 'apt search'
    abbr -a aptup 'sudo apt update && sudo apt upgrade'
end

# ssh
abbr -a vssh 'ssh vshraya'
abbr -a opal 'ssh opalstack'
abbr -a ppink 'ssh phosphor.pink'

# dl
if in-path wget
    abbr -a dl "wget"
else if in-path curl
    abbr -a dl "curl -OJ"
end

# flushdns
if is-macos
    abbr --add flushdns "sudo dscacheutil -flushcache; and sudo killall -HUP mDNSResponder"
else if is-cygwin
    abbr --add flushdns "ipconfig /flushdns"
end

# today/thisweek
if in-path fd
    abbr --add today "fd --changed-within 24h"
    abbr --add thisweek "fd --changed-within 7d"
else
    abbr --add today "find -mtime -1"
    abbr --add thisweek "find -mtime -7"
end

# uuid
in-path uuidgen
and abbr --add uuid "uuidgen | string lower | tbcopy"

# ----------------------------------------------------------------------------
# advanced
# ----------------------------------------------------------------------------

fish-is-newer-than 3.6; or return

# "set --verbose"
# sv.files → `set files %; set -S files`
function __abbr_setv
    set -l varname (string replace "sv." "" $argv[1])
    echo "set $varname %; set -S $varname"
end
abbr -a setv --regex "sv\..+" --set-cursor --function __abbr_setv

# quick for loop
# for.thing → `for thing in $things; %; end`
function __abbr_for_var
    set -l varname (string replace "for." "" $argv[1])
    echo "for $varname in \$"$varname"s; %; end"
end
abbr -a for_var --regex "for\..+" --set-cursor --function __abbr_for_var

# bash-like quick history substitution
# ^string1^string2 → repeats the last command, replacing string1 with string2
function __abbr_history_subst
    string match -rq "\^(?<str1>.+)\^(?<str2>.+)" $argv; or return
    string replace $str1 $str2 $history[1]
end
abbr -a history_subst --regex "\^(.+)\^(.+)" --set-cursor --function __abbr_history_subst
