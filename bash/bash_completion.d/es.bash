# for my "edit shell script" function (../functions.d/es.bash)

__z_complete_es()
{
  # must be kept in sync w/ same declaration in es()
  local -a script_dirs=( "$HOME/scripts" "$HOME/scripts"/*/ )
  local -a wordlist

  mapfile -t wordlist  < <(__z_complete_filenames sh "${script_dirs[@]}")
  mapfile -t COMPREPLY < <(compgen -W "${wordlist[*]}" -- "${COMP_WORDS[COMP_CWORD]}")
}

complete -F __z_complete_es -- es
