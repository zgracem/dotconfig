function scratch --description 'Create a temporary directory and change into it'
  # Inspired by <https://sanctum.geek.nz/cgit/dotfiles.git/tree/sh/shrc.d/scr.sh>
  set -l template (status current-function)
  set -q argv[1]; and set template $argv[1]

  # be BSD/GNU-agnostic vis-á-vis mktemp(1)
  is-gnu mktemp; and set template "$template.XXXXXX"

  set -l dir (mktemp -d -t "$template"); and cd "$dir"
end
