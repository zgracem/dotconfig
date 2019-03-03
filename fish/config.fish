# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

set -gx FISH_VERSINFO (string split "." "$FISH_VERSION")

if test $FISH_VERSINFO[1] -lt 3
  begin
    echo (set_color black --background red) ">>>" (set_color bryellow) \
      "This configuration file cannot run on fish" $FISH_VERSION \
      (set_color black) "<<<" (set_color normal)
  end >&2
  exit 1
else
  source "$__fish_config_dir/paths.fish"
  source "$__fish_config_dir/aliases.fish"

  # function subdirectories
  for dir in $__fish_config_dir/functions/**/
    set -p fish_function_path (string trim -rc/ $dir)
  end

  # load per-machine configuration if available
  set -g __fish_config_dir_local ~/.local/config/fish
  if test -d $__fish_config_dir_local
    if test -d $__fish_config_dir_local/conf.d
      for file in $__fish_config_dir_local/conf.d/*.fish
        source "$file"
      end
    end
    set -p fish_function_path $__fish_config_dir_local/functions
  end

  if status is-interactive
    # setup colours
    source "$__fish_config_dir/colours.fish"

    # activate custom prompt
    set -p fish_function_path "$__fish_config_dir/prompt"
  end

  status test-feature qmark-noglob
  if test $status -eq 1
    set -Ua fish_features qmark-noglob
  end
end
