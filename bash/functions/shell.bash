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
    command mkdir -p "$1" && cd "$1"
}

cdls()
{   # change to, and immediately list, a directory
    cd "$@" && ls $flags_ls
}

lsf()
{   # "full" info
    declare flags="lAip" colourFlag=" --color=auto"

    [[ $OSTYPE =~ darwin ]] && {
        flags+="@O"
        colourFlag="G"
    }

    /bin/ls -$flags$colourFlag "$@"
}

lsd()
{   # list all subdirectories in $1/$PWD
    find "${1-.}" -maxdepth 1 -type d -exec ls $flags_ls -d {} \;
}

lsl()
{   # list all symbolic links in $1/$PWD
    find "${1-.}" -maxdepth 1 -type l -exec ls $flags_ls {} \;
}

lsx()
{   # list all files in $PWD that match *.$1
    find . -maxdepth 1 -type f -iname '*.'${1}'' -exec ls $flags_ls {} \;
}

lspath()
{   # list path entries of $PATH or environment variable $1
    declare listPath="${1-\$PATH}"
    eval echo ${listPath} | tr : '\n'
}

today()
{   # list all files under $PWD changed today
    declare findBin=$(getGNU find) || {
            printf "%s: GNU find(1) required\n" $FUNCNAME 1>&2
            return 1
        }

    "$findBin" . -maxdepth 1 -type f -daystart -mtime 0 -print
}

flatten()
{   # flatten a directory structure
    # https://github.com/ymendel/dotfiles/blob/master/system/functions.bash
    declare targetDir=${1-.}

    find $targetDir -type f -mindepth 2 -exec mv {} $targetDir \;
    find $targetDir -type d -d -depth 1 -exec rm -rf {} \;
}

rootme()
{   # temporarily become root for $1 minutes (default is 3)

    declare timeout=$(( ${1:-3} * 60 ))

    _inPath sudo || {
        scold $FUNCNAME "this system does not support sudo"
        return 1
    }

    # rename window, if applicable
    [[ $STY  ]] && echo -ne "\eksudo\e\\"
    [[ $TMUX ]] && tmux rename-window sudo

    sudo \
        ${STY:+STY=$STY} \
        ${TMUX:+TMUX=$TMUX} \
        TMOUT=$timeout \
        -s

    # restore window name
    [[ $STY  ]] && echo -ne "\ekbash\e\\"
    [[ $TMUX ]] && tmux set-window-option automatic-rename on >/dev/null
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
    _shoptSet dotglob  && dotglob=true
    _shoptSet nullglob && nullglob=true

    # populate files array
    shopt -s dotglob nullglob
    files=("$dir"/*)

    # reset options
    [[ $dotglob == true ]]  || shopt -u dotglob
    [[ $nullglob == true ]] || shopt -u nullglob

    # print result
    printf '%d\t%s\n' "${#files[@]}" "$dir"
}
