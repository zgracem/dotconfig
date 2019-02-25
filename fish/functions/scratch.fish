function scratch -a template --description 'Create a temporary directory and change into it'
  # Inspired by <https://sanctum.geek.nz/cgit/dotfiles.git/tree/sh/shrc.d/scr.sh>
  set -q template; or set -l template (status current-function)

  # be BSD/GNU-agnostic vis-á-vis mktemp(1)
  is-gnu mktemp; and set template "$template.XXXXXX"

  set -l dir (mktemp -d -t "$template"); and cd "$dir"
end
