es()
{ # edit a script

  local dir
  for dir in "$dir_scripts"/{,dev,util,work}; do
    local script="$dir/${1%.sh}.sh"

    if [[ -f $script ]]; then
      _edit "$script"
      return 0
    fi
  done

  # no script, try editing a function instead & exit w/ fe's error code
  ef "$1"
}

# Has custom completions in ../bash_completion.d
