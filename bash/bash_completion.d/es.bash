# for my "edit shell script" function (../functions.d/es.bash)

__z_complete_es()
{
  # must be kept in sync w/ same declaration in es()
  local -a script_dirs=( "$dir_scripts"{,/dev,/util,/work} )

  local -a wordlist=( $(__z_complete_files sh "${script_dirs[@]}") )

  COMPREPLY=( $(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}" ) )
}

complete -F __z_complete_es -- es
