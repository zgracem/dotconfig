# -----------------------------------------------------------------------------
# ~zozo/.config/bash/prefs
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# default flags
# -----------------------------------------------------------------------------

flags_alpine='-i -p $dir_config/alpine/pinerc -passfile $dir_config/alpine/alpine-passfile'
flags_calendar='-A0 -f $HOME/.calendar'
flags_cp='-aipv'        # archive mode; interactive; preserve attributes; verbose
flags_dos2unix='-k'     # copy date stamp to output file
flags_file='-p'         # don't touch last-accessed time
flags_hexdump='-C'      # "canonical" display mode
flags_ln='-v'           # verbose
flags_ls='-Ap'          # (almost) all files; append / to directories
flags_mkdir='-p -v'     # create parents as required; verbose
flags_mosh="--server=/usr/local/bin/mosh-server"
flags_mv='-iv'          # interactive; verbose
flags_ps='-a'           # all users
flags_rm='-iv'          # interactive; verbose
flags_rsync='-ahvzEX'   # archive mode; human sizes; verbose; compress; preserve exec/xattrs
flags_scp='-Cpr'        # compress; preserve times/modes; recursive
flags_stat='-L'         # follow links
flags_top='-F -R -u -user $USER'

# Silver Searcher
flags_ag='--path-to-agignore "${dir_config}/agignore" '
flags_ag+='--skip-vcs-ignores '
flags_ag+='--color-line-number "0;34" '
flags_ag+='--color-match "4;1;31" '
flags_ag+='--color-path "1;32" '
flags_ag+='--noheading '
flags_ag+='--smart-case '

# Google Chrome
flags_chrome='--allow-file-access '
flags_chrome+='--allow-file-access-from-files '

if [[ -n $SOCKS5_SERVER ]]; then
    flags_chrome+="--proxy-server='socks5://${SOCKS5_SERVER}' "
fi

# platform-specific

if _isGNU ls; then
    flags_ls+=' --color=auto'
fi

if _isGNU ps; then
    flags_ps+='s'   # summary format

    # also show Windows processes
    [[ $OSTYPE =~ cygwin ]] \
        && flags_ps+='W'

else
    flags_ps+='xo pid,ppid,user,start,command'
fi

if ! _isGNU stat; then
    flags_stat+=' -x -t "%F %T"'
fi

export ${!flags_*}

# add flags to aliases

for flag in ${!flags_*}; do
    # get app name
    app=${flag#flags_}

    # if we have the app, create an alias with the preferred flags
    _inPath $app \
        && alias $app="${app} ${!flag}"
done

# were you born in a barn?
unset app flag

# -----------------------------------------------------------------------------
# settings -- config files
# -----------------------------------------------------------------------------

export CURLRC="${dir_config}/curlrc"
export INPUTRC="${dir_config}/inputrc"
export NETHACKOPTIONS="@${dir_config}/nethackrc"
export PIP_CONFIG_FILE="${dir_config}/pip.conf"
export SCREENRC="${dir_config}/screenrc"

alias curl='curl -K "${CURLRC}"'

# -----------------------------------------------------------------------------
# settings -- environment variables
# -----------------------------------------------------------------------------

export BLOCKSIZE=1024

# git
export GIT_AUTHOR_NAME='Zozo'
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_AUTHOR_EMAIL='zozo@inescapable.org'
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# grep (see also colours.bash)
export GREP_OPTIONS=
GREP_OPTIONS+='--extended-regexp '  # use ERE syntax (-E)
GREP_OPTIONS+='--colour=auto '      # display results in colour
GREP_OPTIONS+='--no-messages '      # no errors about missing/unreadable files (-s)
GREP_OPTIONS+='--directories=skip ' # silently skip directories by default (-d)
GREP_OPTIONS+='--exclude-dir=.git'  # skip .git directories

# mailcaps
export MAILCAPS="${HOME}/share/mailcap:${HOME}/.mailcap:/etc/mailcap"

# tar
export COPYFILE_DISABLE=true        # exclude ._resourceforks from tarballs
export COMP_TAR_INTERNAL_PATHS=1    # avoid flattening contents of tar files

# zip
export ZIPOPTS='-9 --symlinks'      # max compression, store symlinks as symlinks

# OpenSSL
export SSL_CERT_DIR='/usr/local/etc/openssl'
export SSL_CERT_FILE="${SSL_CERT_DIR}/cert.pem"
export CURL_CA_BUNDLE="${SSL_CERT_DIR}/certs/ca-bundle.crt"

for x in SSL_CERT_DIR SSL_CERT_FILE CURL_CA_BUNDLE; do
    if [[ ! -e ${!x} ]]; then
        unset $x
    fi
    unset x
done

export GIT_SSL_CAINFO="$SSL_CERT_FILE"

# Transmission
export TRANSMISSION_HOME="${HOME}/.config/transmission"
export TRANSMISSION_WEB_HOME="${HOME}/Library/Application Support/transmission-daemon/web"

if [[ ! -d $TRANSMISSION_WEB_HOME ]]; then
    unset TRANSMISSION_WEB_HOME
fi

# XDG
export XDG_DATA_HOME="${HOME}/share"
export XDG_CONFIG_HOME="$dir_config"
export XDG_CACHE_HOME="${HOME}/Library/Caches"

# StarDict
export STARDICT_DATA_DIR="${HOME}/share/dict/stardict"
export SDCV_HISTSIZE=0
export SDCV_PAGER="${SDCV_PAGER:=$(getPath less)}"

# -----------------------------------------------------------------------------
# less
# -----------------------------------------------------------------------------

export LESS=
LESS+='--QUIET '                # never ring the terminal bell [-Q]
LESS+='--ignore-case '          # case-insensitive searching [-i]
LESS+='--squeeze-blank-lines '  # combine consecutive blank lines [-s]
LESS+='--no-init '              # don't clear the screen on exit [-X]

export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null   # don't keep a history file

if lesspipe="$(getPath src-hilite-lesspipe.sh)"; then
    export LESSOPEN="| ${lesspipe} %s"  # source highlighting
    LESS+='--RAW-CONTROL-CHARS '        # output raw ANSI (e.g. \e[1;31m) [-R]
    unset lesspipe
fi

# -----------------------------------------------------------------------------
# architecture & multi-core processing
# -----------------------------------------------------------------------------

export NUMBER_OF_PROCESSORS="${NUMBER_OF_PROCESSORS:=$(getconf _NPROCESSORS_ONLN 2>&-)}"

if [[ $NUMBER_OF_PROCESSORS -gt 1 ]]; then
    export MAKEFLAGS="-j${NUMBER_OF_PROCESSORS}"
fi

if _inPath sysctl; then
    export PROCESSOR_ARCHITECTURE="${PROCESSOR_ARCHITECTURE:=$(sysctl -n hw.machine)}"
fi

if [[ -n $PROCESSOR_ARCHITECTURE && ! $ARCHFLAGS =~ -arch ]]; then
    export ARCHFLAGS="${ARCHFLAGS:+$ARCHFLAGS }-arch ${PROCESSOR_ARCHITECTURE}"
fi

# -----------------------------------------------------------------------------

return 0
