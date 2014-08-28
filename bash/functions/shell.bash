# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/shell.bash
# replacements for shell functions
# ------------------------------------------------------------------------------

cd()
{
    declare dir=${1:-$HOME}
    pushd "$dir" 1>/dev/null
}

alias --  -='pushd +1 1>/dev/null'  # -  = go back 1 dir
alias -- --='pushd -0 1>/dev/null'  # -- = go forward 1 dir

mkcd()
{   # create a directory then move into it
    command mkdir -p "$1" \
        && cd "$1"
}

cdls()
{   # change to, and immediately list, a directory
    cd "$@" \
        && ls $flags_ls
}

lsf()
{   # "full" info
    declare flags="lAip" colourFlag=" --color=auto"

    if [[ $OSTYPE =~ darwin ]]; then
        flags+="@O"
        colourFlag="G"
    fi

    /bin/ls -$flags$colourFlag "$@"
}

lsd()
{   # list all subdirectories in $1/$PWD
    find "${1-.}" -maxdepth 1 -type d \
    | xargs ls -d ${flags_ls}
}

lsl()
{   # list all symbolic links in $1/$PWD
    find "${1-.}" -maxdepth 1 -type l \
    | xargs ls ${flags_ls}
}

lsx()
{   # list all files in $PWD that match *.$1
    find . -maxdepth 1 -type f -iname '*.'${1}'' \
    | xargs ls ${flags_ls}
}

lspath()
{   # list path entries of $PATH or environment variable $1
    declare listPath="${1-PATH}"

    echo ${!listPath} \
    | tr : '\n'
}

flatten()
{   # flatten a directory structure
    # https://github.com/ymendel/dotfiles/blob/master/system/functions.bash
    declare targetDir=${1-.}

    find "$targetDir" -type f -mindepth 2 \
        -exec mv {} "$targetDir" \;

    find "$targetDir" -type d -d -depth 1
        -exec rm -rf {} \;
}

rootme()
{   # temporarily become root for $1 minutes (default is 3)

    declare timeout=$(( ${1:-3} * 60 ))

    if ! _inPath sudo; then
        scold $FUNCNAME "this system does not support sudo"
        return 1
    fi

    # rename window, if applicable
    [[ $STY  ]] \
        && echo -ne "\eksudo\e\\"

    [[ $TMUX ]] \
        && tmux rename-window sudo

    sudo \
        ${STY:+STY=$STY} \
        ${TMUX:+TMUX=$TMUX} \
        TMOUT=$timeout \
        -s

    # restore window name
    [[ $STY  ]] \
        && echo -ne "\ekbash\e\\"

    [[ $TMUX ]] \
        && quietly tmux set-window-option automatic-rename on
}

pause()
{   # hold for a single keypress
    
    declare anykey message="$@"

    : ${message:=Press any key to continue...}

    printf "%s" "$message"
    read -s -n1 anykey
    printf "%b" "\n"
}

numfiles()
{   # return the number of files in $PWD (or $1)
    # Based on: https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/cf.bash

    declare dir="${1-$PWD}" dotglob nullglob
    declare -a files

    # check target directory
    if [[ ! -e $dir ]]; then
        scold "$FUNCNAME" "$dir: not found"
        return 1
    elif [[ ! -d $dir ]]; then
        scold "$FUNCNAME" "$dir: not a directory"
        return 1
    elif [[ ! -r $dir ]]; then
        scold "$FUNCNAME" "$dir: not readable"
        return 1
    fi

    # capture glob settings
    _shoptSet dotglob \
        && dotglob=true
    _shoptSet nullglob \
        && nullglob=true

    # populate files array
    shopt -s dotglob nullglob
    files=("$dir"/*)

    # reset options
    [[ $dotglob == true ]] \
        || shopt -u dotglob

    [[ $nullglob == true ]] \
        || shopt -u nullglob

    # print result
    printf '%d\t%s\n' "${#files[@]}" "$dir"
}

escape()
{   # escape UTF-8 characters into their three-byte format
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    newline
}

if ! _inPath sudo; then
    unalias sudo 2>/dev/null
    unset -f sudo

    # just pass through commands
    sudo() { $*; }
fi

newline()
{   # print a newline if output is going to a terminal

    if [[ -t 1 ]]; then
        printf "%b" "\n"
    else
        return 0
    fi
}
