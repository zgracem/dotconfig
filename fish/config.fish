# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

set FISH_VERSINFO (string split "." "$FISH_VERSION")

if [ $FISH_VERSINFO[1] -lt 3 ]
  echo >&2 "This configuration file cannot run on fish $FISH_VERSION"
  exit 1
end

source "$__fish_config_dir/paths.fish"
source "$__fish_config_dir/aliases.fish"

if status is-interactive
  source "$__fish_config_dir/colours.fish"
  set -p fish_function_path "$__fish_config_dir/prompt"
  fish_vi_key_bindings insert
end
