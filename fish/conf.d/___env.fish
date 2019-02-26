set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME "$HOME/var/cache"
set -q XDG_RUNTIME_DIR; or set -gx XDG_RUNTIME_DIR "$HOME/var/run"

if set -q ENV; and string match -eq 'fish' "$SHELL"
  # Use sh(1) to populate the environment from ~/.config/environment.d.
  # Both the -l and -i flags are needed to prevent an infinite loop.
  exec sh -l -i -c "exec $SHELL"
end
