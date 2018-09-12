gitupdate()
{ #: - updates all git repos in a given directory (or PWD)
  #: $ gitupdate [<dir>]
  local target_dir="${1-$PWD}"

  local -a dirs=()
  
  local dir; for dir in "$target_dir"/**/.git; do
    [[ -d $dir ]] || continue
    dir="${dir%/.git}"
    printf '» %s\n' "$dir"
    (builtin cd "$dir" && git pull) || return 70
  done
}
