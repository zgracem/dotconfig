# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

set -q USER; or set USER (id -un)
set -q HOSTNAME; or set HOSTNAME (uname -n)

# -----------------------------------------------------------------------------

set FISH_VERSINFO (string split "." "$FISH_VERSION")

if test $FISH_VERSINFO[1] -lt 3
  echo "This configuration file cannot run on fish $FISH_VERSION"
  exit
end

source "$__fish_config_dir/paths.fish"
source "$__fish_config_dir/aliases.fish"

if status is-interactive
  source "$__fish_config_dir/colours.fish"
  fish_vi_key_bindings insert
end
