es()
{ #: - edit a script
  #: $ es <script>

  local search="$1"

  local -a script_dirs=( "$dir_scripts" "$dir_scripts"/*/ )
  local -a script_exts=(sh rb)
  local -a scripts=()

  local dir ext scr
  for dir in "${script_dirs[@]}"; do
    for ext in "${script_exts[@]}"; do
      scr="$dir/$1.$ext"
      [[ -f $scr ]] && scripts+=("$scr")
    done
  done

  case ${#scripts[@]} in
    0)  # No script; try editing a function instead & exit w/ ef()'s error code
        ef "$1" || {
          scold "not found: $1"
          return 66
        }
        ;;
    1)  _z_edit "${scripts[0]}"
        return 0
        ;;
    *)
        local PS3="q) cancel"$'\n'"#? "

        select scr in "${scripts[@]}"; do
          if [[ $REPLY == "q" ]]; then
            return
          elif [[ -f $scr ]]; then
            _z_edit "$scr"
            return
          else
            scold "invalid option: $REPLY"
            PS3="${PS3##*$'\n'}"
          fi
        done
        ;;
  esac
}

# Has custom completions in ../bash_completion.d
