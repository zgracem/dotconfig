# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

if [ (string split "." "$FISH_VERSION")[1] -lt 3 ]
  begin
    set_color red
    echo "This configuration file cannot run on fish $FISH_VERSION"
    set_color normal
  end >&2
  exit 1
end

source "$__fish_config_dir/paths.fish"
source "$__fish_config_dir/aliases.fish"

if status is-interactive
  source "$__fish_config_dir/colours.fish"
  set -p fish_function_path "$__fish_config_dir/prompt"
  fish_vi_key_bindings insert
end
