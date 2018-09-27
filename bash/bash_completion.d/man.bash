# shellcheck disable=SC2206
__z_complete_man()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}

  shopt -q nullglob || trap 'shopt -u nullglob; trap - RETURN;' RETURN
  shopt -s nullglob

  if [[ $cur == -* ]]; then
    # TODO: add option handling
    return 0
  elif [[ "$cur" == @(*/|[.~])* ]]; then
    # looks like a path; do file-based completion
    return 0
  fi

  # shellcheck disable=SC2153
  if [[ -z $MANPATH ]]; then
    # skip MANPATH searching and just return commands
    mapfile -t COMPREPLY < <(compgen -c -- "$cur")
    return 0
  else
    local manpath=$MANPATH:
  fi

  local sections="@([0-9lnp]|[0-9][px]|3?(gl|pm))"
  local section
  if [[ $prev == "$sections" ]]; then
    section=$prev
  else
    section='*'
  fi

  if [[ -n $cur ]]; then
    manpath="${manpath//://*man$section/$cur* } ${manpath//://*cat$section/$cur* }"
  else
    manpath="${manpath//://*man$section/ } ${manpath//://*cat$section/ }"
  fi

  # collect man page filenames
  local -a reply=( ${manpath} )

  # remove paths
  reply=( ${reply[@]##*/?(:)} )

  # remove suffixes
  local suffixes=".@([glx]z|bz2|lzma|Z)"
  reply=( ${reply[@]%$suffixes} )
  mapfile -t reply < <(compgen -W "${reply[@]%.*}" -- "${cur//\\\\/}")

  if [[ $prev != "$sections" ]]; then
    # file-based completion
    compopt -o filenames 2>/dev/null #debug
    local extensions="@([0-9lnp]|[0-9][px]|man|3?(gl|pm))?(${suffixes})"
    reply+=( ./*.${extensions} )
  fi

  COMPREPLY=( "${reply[@]}" )
}

complete -o default -F __z_complete_man -- man
