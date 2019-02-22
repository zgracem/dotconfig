# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

set -q USER; or set -gx USER (id -un)
set -q HOSTNAME; or set -gx HOSTNAME (uname -n)

# -----------------------------------------------------------------------------

set FISH_VERSINFO (string split "." "$FISH_VERSION")

if [ $FISH_VERSINFO[1] -lt 3 ]
  echo >&2 "This configuration file cannot run on fish $FISH_VERSION"
  exit 1
end

if [ -z "$ENV" ]
  # Use sh(1) to populate the environment from ~/.config/environment.d.
  # Both the -l and -i flags are needed to prevent an infinite loop.
  exec sh -l -i -c "exec "(status fish-path)
end

source "$__fish_config_dir/paths.fish"
source "$__fish_config_dir/aliases.fish"

if status is-interactive
  source "$__fish_config_dir/colours.fish"
  fish_vi_key_bindings insert
end
