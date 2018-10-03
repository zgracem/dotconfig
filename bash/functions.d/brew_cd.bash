_inPath brew || return

brew_cd()
{ #: - navigate to important Homebrew directories
  #: $ brew_cd [cache|cellar|prefix|repo[sitory]]
  local destination="$1"
  case $destination in
    cache|cellar|prefix|repo|repository)
      cd "$(brew "--$destination")" || return
      ;;
    *)
      printf "%s: destination unknown\\n" "$destination" >&2
      return 1
      ;;
  esac
}
