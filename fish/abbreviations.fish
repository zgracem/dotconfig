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
    function __abbr_cd_dotdot
        echo -n cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end

    abbr --add cd_dotdot --regex '^\.\.+$' --function __abbr_cd_dotdot
end

# `-` and `--` go back and forth in dir history
abbr --add -- "-" prevd
abbr --add -- "--" nextd

# ----------------------------------------------------------------------------
# default options
# ----------------------------------------------------------------------------

abbr --add cp "cp -aiv" # preserve attributes; ask before clobbering; verbose
abbr --add file "file -p" # don't touch last-accessed time
abbr --add killall "killall -v"
abbr --add ln "ln -v"
abbr --add mkdir "mkdir -pv"
abbr --add rename "rename -v"
abbr --add stow "stow -v"
abbr --add restow "stow -v --restow"
abbr --add trash "trash -v"
abbr --add unstow "stow -v --delete"
abbr --add xxd "xxd -u -g1" # -u = uppercase; -g1 = 1 octet per group

set -l _chmod_verbose_flag
if is-gnu chmod
    set _chmod_verbose_flag "-c" # show only changes
else
    set _chmod_verbose_flag "-v" # show all operations
end
abbr --add chmod "chmod $_chmod_verbose_flag"
abbr --add chown "chown $_chmod_verbose_flag"
abbr --add "ux" "chmod $_chmod_verbose_flag u+x"
abbr --add "gorx" "chmod $_chmod_verbose_flag go+rx"

functions --erase ls ll
if command -q eza
    abbr --add ls "eza -a"
    abbr --add ll "eza -la"
    functions --erase lsf
    abbr --add lsf "eza -lagi@"
else if is-gnu ls
    abbr --add ls "ls -A --color"
    abbr --add ll "ls -lhA --color"
else
    abbr --add ls "ls -AG"
    abbr --add ll "ls -lAG"
end

if command -q fd
    set -l _fd_default_flags "-L" # --follow
    abbr --add fd "fd $_fd_default_flags"
    abbr --add fdd "fd $_fd_default_flags -td"
    abbr --add fdf "fd $_fd_default_flags -tf"
    abbr --add fda "fd $_fd_default_flags -u" # --unrestricted = --hidden --no-ignore
    abbr --add ff "fd $_fd_default_flags -tf --full-path"
end

command -q manpdf; and not set -q SSH_CONNECTION
and abbr --add manpdf "manpdf -o -f"

if is-macos
    # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    abbr --add mv "/bin/mv -iv"
else
    abbr --add mv "mv -iv"
end

if is-gnu rm
    abbr --add rm "rm -Iv" # -I = prompt before large operations
else
    abbr --add rm "rm -iv" # -i = request confirmation before each file
end

# -----------------------------------------------------------------------------
# shortcuts
# -----------------------------------------------------------------------------

abbr -a dr 'defaults read'
abbr -a dw 'defaults write'
abbr -a e 'echo'
abbr -a mime 'file --brief --mime-type'
abbr -a s 'set --show'
abbr -a ssc 'sudo systemctl'
abbr -a svim 'sudo -E vim'
abbr -a unset 'set --erase'

abbr -a 'comp?' compsrc
abbr -a 'func?' funcsrc
abbr -a 'man?' command man -aw

abbr -a rank -p anywhere 'sort | uniq -c | sort -nr'

# f + reveal
if is-macos
    functions --erase f reveal
    abbr --add f "open -a Finder ."
    abbr --add reveal "open -R"
end

# apt
if command -q apt
    abbr -a aptins 'sudo apt install'
    abbr -a aptinf 'apt show'
    abbr -a apts 'apt search'
    abbr -a aptup 'sudo apt update && sudo apt upgrade'
end

# Homebrew
if command -q brew
    abbr -a brin 'brew info'
    abbr -a brins 'brew install'
    abbr -a brs 'brew search'
    abbr -a brhome 'brew home'
    abbr -a brrm 'brew uninstall'
    abbr -a brre 'brew reinstall'
    abbr -a brls 'brew list'
    abbr -a brwh 'brew which-formula'
    abbr -a brupg 'brew upgrade'
    abbr -a brupd 'brew update'
end

# ssh
abbr -a vssh 'ssh vshraya'
abbr -a opal 'ssh opalstack'
abbr -a ppink 'ssh phosphor.pink'
abbr -a alyx 'ssh Alyx'

# dl
if command -q wget
    abbr -a dl "cd ~/Downloads; wget"
else if command -q curl
    abbr -a dl "cd ~/Downloads; curl -OJ"
end

# today/thisweek
if command -q fd
    abbr --add today "fd --changed-within 24h"
    abbr --add thisweek "fd --changed-within 7d"
else
    abbr --add today "find -mtime -1"
    abbr --add thisweek "find -mtime -7"
end

# uuid
command -q uuidgen
and abbr --add uuid "uuidgen | string lower | tbcopy"

# ----------------------------------------------------------------------------
# advanced
# ----------------------------------------------------------------------------

fish-is-newer-than 3.6; or return

# imitate `cd -P`
# cdp → cd (path resolve %)
functions --erase cdp
function __abbr_cdp
    echo "cd (path resolve %)"
end
abbr -a cdp --set-cursor --function __abbr_cdp

# copy to clipboard, then print in columns
# CC → `% | tbcopy | column`
abbr -a CC --position anywhere --set-cursor "% | tbcopy | column"

# DD = extremely fast dump-to-desktop
abbr -a DD --position anywhere --set-cursor "| tee ~/Desktop/%.txt"

# "set --verbose"
# sv.files → `set files %; set -S files`
function __abbr_setv
    set -l varname (string split -f2 . $argv[1])
    echo "set $varname %; set -S $varname"
end
abbr -a setv --regex "sv\..+" --set-cursor --function __abbr_setv

# quick for loop
# for.thing → `for t in $things; %; end`
function __abbr_for_var
    set -l varname (string split -f2 . $argv[1] | string trim -cs -r)
    set -l v (string sub -l1 $varname)
    echo "for $v in \$"$varname"s; %; end"
end
abbr -a for_var --regex "for\..+" --set-cursor --function __abbr_for_var

# bash-like quick history substitution
# ^string1^string2 → repeats the last command, replacing string1 with string2
function __abbr_history_subst
    string match -rq "\^(?<str1>.+)\^(?<str2>.+)" $argv; or return
    string replace -a $str1 $str2 $history[1]
end
abbr -a history_subst --regex "\^.+\^.+" --function __abbr_history_subst

# zsh-style expansion
# =fish → `/usr/local/bin/fish`
function __abbr_zequals
    set -l cmdname (string replace "=" "" $argv[1])
    command -s $cmdname
end
abbr -a zequals --position anywhere --regex "=\w+" --function __abbr_zequals

# quick Homebrew Cask
# cask.info → brew info --cask
function __brew_cask
    set -l cmd (string split -f2 . $argv[1])
    echo "brew $cmd --cask"
end
abbr -a brew_cask --regex "cask\..+" --function __brew_cask
