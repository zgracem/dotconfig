_inPath brew || return

brew_cd()
{ #: - navigate to important Homebrew directories
  local destination="$1"; shift

  case $destination in
    cache|cellar|prefix|repo|repository)
      cd "$(brew --$destination)"
      ;;
    *)
      printf "%s: destination unknown\\n" "$destination" >&2
      return 1
      ;;
  esac
}
