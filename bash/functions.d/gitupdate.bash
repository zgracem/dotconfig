gitupdate()
{
  local target_dir="${1:-$PWD}"

  local -a dirs=()
  
  local dir; for dir in "$target_dir"/**/.git; do
    [[ -d $dir ]] || continue
    dir="${dir%/.git}"

    echo "$dir"
    # (cd "$dir" && git pull) || return 1
  done
}
