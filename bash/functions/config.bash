# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/config.bash
# edit/reload config files
# -----------------------------------------------------------------------------

confed()
{   # edit
    declare file="$dir_config/bash/$1"

    # does the file exist?
    [[ -f $file ]] ||
        return 1

    # convert to Windows-style path if necessary
    [[ $OSTYPE =~ cygwin ]] &&
        file="$(cygpath -aw "$file")"

    _edit "$file"
}

bf()
{
    [[ $# -eq 0 ]] && {
        confed functions.bash
    } || {
        declare file
        for file in "$@"; do
            confed "functions/$file.bash"
        done
    }
}

rl()
{   # reload
    [[ $# -eq 0 ]] && {
        confsrc profile
    } || {
        confsrc "$@"
    }
}

   alias ba='confed aliases.bash'
  alias brc='confed bashrc.bash'
 alias bcal='confed calendar.bash'
 alias bcol='confed colours.bash'
 alias bcom='confed completion.bash'
 alias bcyg='confed cygwin.bash'
 alias bexp='confed exports.bash'
 alias bloc='confed "../local/$HOSTNAME/bashrc.bash"'
 alias bmac='confed osx.bash'
alias bpath='confed paths.bash'
 alias bpla='confed places.bash'
alias bpref='confed prefs.bash'
 alias bpri='confed private.bash'
 alias bpro='confed profile.bash'
alias bprog='confed programs.bash'
 alias bps1='confed prompt.bash'
alias vimrc='confed ../vimrc'
