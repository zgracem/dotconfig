# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/config.bash
# edit/reload config files
# -----------------------------------------------------------------------------

confed()
{   # edit a config file
    declare file="$dir_config/bash/$1"

    # does the file exist?
    [[ -f $file ]] \
        || return 1

    _edit "$file"
}

rl()
{   # reload a config file
    if [[ $# -eq 0 ]]; then
        unset BASH_COMPLETION_SOURCED SYSPATH colourdepth
        _source "$dir_config/bash/profile.bash"
    else
        for dotfile in "$@"; do
            _source "$dir_config/bash/${dotfile}.bash"
        done
    fi
}

   alias ba='confed aliases.bash'
  alias brc='confed bashrc.bash'
 alias bcal='confed calendar.bash'
 alias bcol='confed colours.bash'
 alias bcom='confed completion.bash'
 alias bcyg='confed cygwin.bash'
 alias bloc='confed "../local/$HOSTNAME/local.bash"'
 alias bmac='confed osx.bash'
alias bpath='confed paths.bash'
 alias bpla='confed places.bash'
alias bpref='confed prefs.bash'
 alias bpri='confed private.bash'
 alias bpro='confed profile.bash'
alias bprog='confed programs.bash'
 alias bps1='confed prompt.bash'
alias vimrc='confed ../vimrc'
alias brewfile='confed ../brew/Brewfile'
