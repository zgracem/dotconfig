# -----------------------------------------------------------------------------
# ~zozo/.config/bash/prefs
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# default flags
# -----------------------------------------------------------------------------

flags_alpine='-i -p $dir_config/alpine/pinerc -passfile $dir_config/alpine/alpine-passfile'
flags_calendar='-A0 -f $HOME/.calendar'
flags_cp='-aiv'     # archive mode; interactive; verbose
flags_dos2unix='-k' # copy date stamp to output file
flags_file='-p'     # don't touch last-accessed time
flags_hexdump='-C'  # "canonical" display mode
flags_ln='-v'       # verbose
flags_ls='-lAgohp'
flags_mkdir='-p -v' # create parents as required; verbose
flags_mv='-iv'      # interactive; verbose
flags_ps='-a'       # all users
flags_rm='-iv'      # interactive; verbose
flags_rsync='--compress --executability --human-readable --perms --times'
flags_scp='-Cpr'    # compress; preserve times/modes; recursive
flags_stat='-L'     # follow links
flags_top='-F -R -u -user $USER'

# platform-specific

_isGNU ls &&
    flags_ls+=' --color=auto'

_isGNU ps && {
    flags_ps+='s'   # summary format

    # also show Windows processes
    [[ $OSTYPE =~ cygwin ]] && flags_ps+='W'

} || {
    flags_ps+='xo pid,user,start,command'
}

_isGNU stat && {
    flags_stat+=' --printf="  File: \"%n\"\n'
    flags_stat+='  Type: %F\t\tSize: %s\n'
    flags_stat+='  Mode: (%4a/%A)\tUid: (%u/%U)\tGid: (%g/%G)\n'
    flags_stat+='Device: %t,%T\tLinks: %h\tInode: %i\n'
    flags_stat+='Access: %x\n'
    flags_stat+='Modify: %y\n'
    flags_stat+='Change: %z\n"'
} || {
    flags_stat+=' -x -t "%F %T"'
}

export ${!flags_*}

# add flags to aliases

for flag in ${!flags_*}; do
    # get app name
    app=${flag#flags_}

    # if we have the app, create an alias with the preferred flags
    _inPath $app &&
        alias $app="$app ${!flag}"
done

# were you born in a barn?
unset app flag

# -----------------------------------------------------------------------------
# settings -- config files
# -----------------------------------------------------------------------------

export INPUTRC="$dir_config/inputrc"
export NETHACKOPTIONS="@$dir_config/nethackrc"
export SCREENRC="$dir_config/screenrc"

alias curl='curl -K $dir_config/curlrc'
alias dropbox="$dir_mybin/dropbox.sh -f $dir_config/dropbox_uploader"

# -----------------------------------------------------------------------------
# settings -- environment variables
# -----------------------------------------------------------------------------

# git
export GIT_AUTHOR_NAME="Zozo"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_AUTHOR_EMAIL="zozo@inescapable.org"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# grep
export GREP_OPTIONS='--colour=auto --directories=skip --extended-regexp'

# less
export LESS='--QUIET --ignore-case --squeeze-blank-lines --no-init'
export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null       # don't keep a history file

# mailcaps
export MAILCAPS=~/share/mailcap:~/.mailcap:/etc/mailcap

# tar
export COPYFILE_DISABLE=true        # exclude ._resourceforks from tarballs
export COMP_TAR_INTERNAL_PATHS=1    # avoid flattening contents of tar files

# zip
export ZIPOPTS='-9 --symlinks'

# OpenSSL
export SSL_CERT_FILE="/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"

[[ -e $SSL_CERT_FILE ]] || unset SSL_CERT_FILE

# Transmission
export TRANSMISSION_WEB_HOME="$HOME/Library/Application Support/transmission-daemon/web"

[[ -e $TRANSMISSION_WEB_HOME ]] || unset TRANSMISSION_WEB_HOME

# -----------------------------------------------------------------------------
# Homebrew
# -----------------------------------------------------------------------------

_inPath brew && {
    # don't print beer emoji when logged in remotely
    [[ $SSH_TTY ]] && HOMEBREW_NO_EMOJI=true

    export ${!HOMEBREW_*}
} || {
    return 0
}
