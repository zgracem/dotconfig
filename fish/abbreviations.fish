# -----------------------------------------------------------------------------
# abbreviations
# -----------------------------------------------------------------------------

# quick navigation
if fish-is-older-than 3.6 # released Jan 2023
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
for mode in 400 600 700 644 744 755
    abbr --add mode "chmod $_chmod_verbose_flag $mode"
end

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
    abbr --add fdd "fd --type=d"
    abbr --add fdf "fd --type=f"
    abbr --add fde "fd --extension"
    abbr --add fda "fd --unrestricted --follow" # --unrestricted = --hidden --no-ignore
    abbr --add fff "fd --full-path"
end

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
abbr -a pman 'manpdf -o'
abbr -a s 'set --show'
abbr -a ssc 'sudo systemctl'
abbr -a svim 'sudo -E vim'
abbr -a unset 'set --erase'

abbr -a 'c?' compsrc
abbr -a 'f?' funcsrc
abbr -a 'm?' mansrc

abbr -a xcl 'sudo xcodebuild -license'
abbr -a xcp 'xcode-select --print-path'
abbr -a xcs 'sudo xcode-select --switch'

abbr -a ds_ 'rm -fv **/.DS_Store'

# newsboat RSS reader
command -q newsboat
and abbr --add nb "newsboat -q"

# f + reveal
if is-macos
    functions --erase f reveal
    abbr --add f "open -a Finder"
    abbr --add f. "open -a Finder ."
    abbr --add reveal "open -R"
end

# apt
if command -q apt
    abbr -a aptins 'sudo apt install'
    abbr -a aptinf 'apt show'
    abbr -a apts 'apt search'
    abbr -a aptup 'sudo apt update && sudo apt -y upgrade'
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

# Homebrew Cask
abbr -a cask --set-cursor "brew % --cask"

# Raspberry Pi
abbr -a rpc "sudo raspi-config"

# AdGuardHome
path is -x /opt/AdGuardHome/AdGuardHome
and abbr --add agh "sudo /opt/AdGuardHome/AdGuardHome -s"

# command-not-found
path is -x /usr/lib/command-not-found
and abbr --add how "/usr/lib/command-not-found --"

# ----------------------------------------------------------------------------
# advanced
# ----------------------------------------------------------------------------

fish-is-newer-than 3.6 # released Jan 2023
or return

# cdls → cd %; ls
abbr -a cdls --set-cursor "cd %; $_ls_command"
abbr -a cdll --set-cursor "cd %; $_ll_command"

# print in columns
# :c → `% | column`
abbr -a :c --position anywhere --set-cursor "%| column"

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

# bash-like substitution of arguments from the current commandline
# !#:4 → the 4th token on the existing command line
# See functions/bang_hash.fish
abbr --add hist_expand_hash --position anywhere --regex "!#:\d+" --function bang_hash

# zsh-style expansion
# =fish → `/usr/local/bin/fish` for executables
# =p → `~/.config/fish/functions/p.fish` for functions
function __abbr_zequals
    set -l cmdname (string trim -c= -l $argv[1])
    if functions -q $cmdname
        set -l funcpath (functions -D $cmdname)
        if path is -f $funcpath
            short_home $funcpath
            return 0
        end
    else if set -l cmdpath (command -s $cmdname)
        short_home $cmdpath
        return 0
    end
    return 1
end
abbr -a zequals --position anywhere --regex "=\S+" --function __abbr_zequals
