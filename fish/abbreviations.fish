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

abbr --add cp "cp -vai" # preserve attributes; ask before clobbering; verbose
abbr --add file "file -p" # don't touch last-accessed time
abbr --add killall "killall -v"
abbr --add ln "ln -sv"
abbr --add mkdir "mkdir -pv"
abbr --add rename "rename -v"
abbr --add stow "stow -v"
abbr --add restow "stow --restow -v"
abbr --add trash "trash -v"
abbr --add unstow "stow --delete -v"
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
set -l _ls_command
set -l _ll_command
if command -q eza
    set _ls_command "eza -a"
    set _ll_command "eza -la"
    functions --erase lsf
    abbr --add lsf "eza -lagi@"
else if is-gnu ls
    set _ls_command "ls --color -A"
    set _ll_command "ls --color -lhA"
else
    set _ls_command "ls -GA"
    set _ll_command "ls -GlA"
end
abbr --add ls $_ls_command
abbr --add ll $_ll_command

if command -q fd
    set -l _fd_default_flags "-L" # --follow
    abbr --add fd "fd $_fd_default_flags"
    abbr --add fdd "fd $_fd_default_flags -td"
    abbr --add fdf "fd $_fd_default_flags -tf"
    abbr --add fda "fd $_fd_default_flags -u" # --unrestricted = --hidden --no-ignore
    abbr --add ff "fd $_fd_default_flags --full-path -tf"
end

command -q manpdf; and not set -q SSH_CONNECTION
and abbr --add manpdf "manpdf -of"

if is-macos
    # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    abbr --add mv "/bin/mv -vi"
else
    abbr --add mv "mv -vi"
end

if is-gnu rm
    abbr --add rm "rm -vI" # -I = prompt before large operations
else
    abbr --add rm "rm -vi" # -i = request confirmation before each file
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

abbr -a xcl 'sudo xcodebuild -license'
abbr -a xcp 'xcode-select --print-path'
abbr -a xcs 'sudo xcode-select --switch'

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

# git
abbr -a ga "git add"
abbr -a gc "git commit"
abbr -a gcm --set-cursor "git commit -m \"%\""
abbr -a gca "git commit --amend --no-edit"
abbr -a gd "git diff"
abbr -a gf "git fetch --prune --all"
abbr -a gpl "git fetch --prune; git merge --ff-only"
abbr -a gps "git push"
abbr -a gs "git status"

# ----------------------------------------------------------------------------
# advanced
# ----------------------------------------------------------------------------

fish-is-newer-than 3.6; or return

# imitate `cd -P`
# cdp → cd (path resolve %)
functions --erase cdp
abbr -a cdp --set-cursor "cd (path resolve %)"

# cdls → cd %; ls
abbr -a cdls --set-cursor "cd %; $_ls_command"
abbr -a cdll --set-cursor "cd %; $_ll_command"

# copy to clipboard, then print in columns
# :cc → `% | tbcopy | column`
abbr -a :cc --position anywhere --set-cursor "% | tbcopy | column"

# :dd = extremely fast dump-to-desktop
abbr -a :dd --position anywhere --set-cursor "| tee ~/Desktop/%.txt"

# "set --verbose"
# sv:files → `set files %; set -S files`
function __abbr_setv
    set -l varname (string split -f2 : $argv[1])
    echo "set $varname %; set -S $varname"
end
abbr -a setv --regex "sv:.+" --set-cursor --function __abbr_setv

# quick for loop
# for:thing → `for t in $things; %; end`
function __abbr_for_var
    set -l varname (string split -f2 : $argv[1] | string trim -cs -r)
    set -l v (string sub -l1 $varname)
    string join \n "for $v in \$"$varname"s" "%" "end"
end
abbr -a for_var --regex "for:.+" --set-cursor --function __abbr_for_var

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
    set -l cmdname (string trim -c= -l $argv[1])
    command -s $cmdname
end
abbr -a zequals --position anywhere --regex "=\w+" --function __abbr_zequals

# quick Homebrew Cask
# cask:info → brew info --cask
function __brew_cask
    set -l cmd (string split -f2 : $argv[1])
    echo "brew $cmd --cask"
end
abbr -a brew_cask --regex "cask:.+" --function __brew_cask
