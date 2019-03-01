# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

set -gx FISH_VERSINFO (string split "." "$FISH_VERSION")

if [ $FISH_VERSINFO[1] -lt 3 ]
  begin
    set_color black --background red
    echo -n " >>> "
    set_color bryellow
    echo -n "This configuration file cannot run on fish" $FISH_VERSION
    set_color black
    echo    " <<< "
    set_color normal
  end >&2
  exit 1
else
  source "$__fish_config_dir/paths.fish"
  source "$__fish_config_dir/aliases.fish"

  if status is-interactive
    source "$__fish_config_dir/colours.fish"
    set -p fish_function_path "$__fish_config_dir/prompt"
    fish_vi_key_bindings insert
  end
end
