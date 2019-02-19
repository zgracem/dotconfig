function ef --wraps funced --description 'Edit a function interactively'
  set -lx TMPDIR "$XDG_RUNTIME_DIR/fish"
  test -d "$TMPDIR"; or mkdir -pv "$TMPDIR"
  funced --save $argv[1]
end
