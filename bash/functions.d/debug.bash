### NOTE: Duplicated in zkit_mini
stacktrace()
{
  local line subroutine filename
  local stack=${#FUNCNAME[@]}

  if [[ -n $1 ]]; then
    stack=$(( stack - $1 )) || return
  fi

  local i; for (( i = 1; i < stack; i++ )); do
    local prefix=""

    filename=${BASH_SOURCE[-$i]}
    line=${BASH_LINENO[-($i+1)]}
    subroutine=${FUNCNAME[-$i]}

    local x; for (( x = 0; x < i; x++ )); do
      prefix+='+'
    done

    if (( i == 1 )); then
      unset -v subroutine
    elif [[ $subroutine == "source" ]]; then
      subroutine="being sourced"
    else
      subroutine="in '$subroutine'"
    fi

    printf '%*s%s:%d%s\n' ${stack} "${prefix:+$prefix }" \
      "${filename}" "${line}" "${subroutine:+ ($subroutine)}"
  done
}

return
### ZGM TODO: finish this

# BASH_XTRACEFD introduced in v4.1
(( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 41 )) || return

debug()
{
    if ! [[ :$SHELLOPTS: =~ :xtrace: ]]; then
        # create log in TMPDIR, capture filename, & output for reference
        export BASH_XTRACELOG=$(printf "$HOME/var/log/bash_debug.$$.log" | tee /dev/stdout)
        # export BASH_XTRACELOG=$(mktemp -q -t "bash_debug.$$.log" | tee /dev/stdout)

        # save PS4 and change it to something helpful
        export OLDPS4=$PS4
        export PS4='+$BASH_SOURCE:$LINENO:$FUNCNAME: '

        # set up a new file descriptor
        exec 4>>"$BASH_XTRACELOG"

        # tell bash to send xtrace output to our new fd
        BASH_XTRACEFD=4

        # turn on xtrace
        set -o xtrace
    else
        # turn it off immediately
        set +o xtrace

        # close our fd
        exec 4>&-

        # remind us where the log is
        echo "$BASH_XTRACELOG"

        # tidy up
        PS4=$OLDPS4
        unset -v BASH_XTRACEFD BASH_XTRACELOG OLDPS4
    fi
}
