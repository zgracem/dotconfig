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
