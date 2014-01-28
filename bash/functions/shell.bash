# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/shell.bash
# replacements for shell functions
# ------------------------------------------------------------------------------

theseFunctions=(
    cd
    mkcd
    cdls
    lsf
    lsd
    lsl
    lsx
    lspath
    today
    flatten
)

unset -f ${theseFunctions[@]}
unalias  ${theseFunctions[@]} 2>/dev/null

# ------------------------------------------------------------------------------

cd()
{
    declare dir=${1:-$HOME}
    pushd "$dir" 1>/dev/null
}

alias --  -='pushd +1 1>/dev/null'
alias -- --='pushd -0 1>/dev/null'

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

# ------------------------------------------------------------------------------

_inPath sudo || {
    unset -f sudo
    unalias sudo 2>/dev/null

    sudo()
    {   # pass through commands (for cygwin)
        $*
    }

    export -f sudo
}
