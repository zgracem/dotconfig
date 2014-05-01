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

export GIT_CONFIG="$dir_local/gitconfig"
export INPUTRC="$dir_config/inputrc"
export NETHACKOPTIONS="@$dir_config/nethackrc"
export SCREENRC="$dir_config/screenrc"

alias curl='curl -K $dir_config/curlrc'
alias dropbox="$dir_mybin/dropbox.sh -f $dir_config/dropbox_uploader"

# -----------------------------------------------------------------------------
# settings -- environment variables
# -----------------------------------------------------------------------------

export BLOCKSIZE=1024
export COPYFILE_DISABLE=true        # exclude ._resourceforks from tarballs
export COMP_TAR_INTERNAL_PATHS=1    # avoid flattening contents of tar files

# git
export GIT_AUTHOR_NAME="Zozo"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_AUTHOR_EMAIL="zozo@inescapable.org"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# grep (see also colours.bash)
export GREP_OPTIONS=
GREP_OPTIONS+='--extended-regexp '  # use ERE syntax (-E)
GREP_OPTIONS+='--colour=auto '      # display results in colour
GREP_OPTIONS+='--no-messages '      # no errors about missing/unreadable files (-s)
# GREP_OPTIONS+='--with-filename '    # prepend results with filename (-H)
GREP_OPTIONS+='--directories=skip ' # silently skip directories by default (-d)
GREP_OPTIONS+='--exclude-dir=.git'  # skip .git directories

# mailcaps
export MAILCAPS=~/share/mailcap:~/.mailcap:/etc/mailcap

# tar
export COPYFILE_DISABLE=true        # exclude ._resourceforks from tarballs
export COMP_TAR_INTERNAL_PATHS=1    # avoid flattening contents of tar files

# zip
export ZIPOPTS='-9 --symlinks'

# OpenSSL
export SSL_CERT_DIR="$HOMEBREW_PREFIX/etc/openssl"
export SSL_CERT_FILE="$SSL_CERT_DIR/cert.pem"
export CURL_CA_BUNDLE="$SSL_CERT_FILE"

for x in SSL_CERT_DIR SSL_CERT_FILE CURL_CA_BUNDLE; do
    if [[ ! -e ${!x} ]]; then
        unset $x
    fi
done

export GIT_SSL_CAINFO="$SSL_CERT_FILE"

# Transmission
export TRANSMISSION_HOME="$HOME/.config/transmission"
export TRANSMISSION_WEB_HOME="$HOME/Library/Application Support/transmission-daemon/web"

# XDG
export XDG_DATA_HOME="$HOME/share"
export XDG_CONFIG_HOME="$dir_config"
export XDG_CACHE_HOME="$HOME/Library/Caches"

# -----------------------------------------------------------------------------
# less
# -----------------------------------------------------------------------------

LESS=
LESS+='--QUIET '                    # never ring the terminal bell
LESS+='--ignore-case '              # case-insensitive searching
LESS+='--squeeze-blank-lines '      # combine consecutive blank lines
LESS+='--no-init '                  # don't clear the screen on exit

LESSCHARSET=utf-8
LESSHISTFILE=/dev/null              # don't keep a history file

lesspipe="$(getPath src-hilite-lesspipe.sh)" && {
    LESSOPEN="| $lesspipe %s"       # source highlighting
    LESS+='--RAW-CONTROL-CHARS'     # output raw ANSI (e.g. \e[1;31m)
    unset lesspipe
}

export LESS{,CHARSET,HISTFILE,OPEN}

# -----------------------------------------------------------------------------
# multi-core processing
# -----------------------------------------------------------------------------

if _inPath sysctl; then
    cores="$(sysctl -n hw.availcpu)"
else
    cores="$(getconf _NPROCESSORS_ONLN)"
fi

if [[ $cores -gt 1 ]]; then
    export MAKEFLAGS="-j$cores"
fi

# -----------------------------------------------------------------------------

return 0
