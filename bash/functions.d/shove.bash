shove() {
#: -- touch a file, creating all intermediary directories
#: $ shove </path/to/new/dir/and/file>
#: * by Daniel Shannon
  mkdir -p "$(dirname "$@")" && touch "$@"
}
