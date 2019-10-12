# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

set -gx FISH_VERSINFO (string split "." "$FISH_VERSION" | string split "-")

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
  for dir in $__fish_config_dir/functions $__fish_config_dir/functions/**/
    set -p fish_function_path (string trim -rc/ $dir)
  end

  # load private and per-machine configuration if available
  for dir in ~/.local/config/fish ~/.private/fish
    if test -d $dir
      if test -d $dir/conf.d
        for file in $dir/conf.d/*.fish; source "$file"; end
      end
      set -p fish_function_path $dir/functions
      set -p fish_complete_path $dir/completions
    end
  end

  if status is-interactive
    # setup colours
    source "$__fish_config_dir/colours.fish"

    # activate custom prompt
    set -p fish_function_path "$__fish_config_dir/prompt"

    # source vendor completions
    set -p fish_complete_path "$HOME/opt/etc/fish/completions"
  end

  # remove duplicate & nonexistent directories
  __fish_fix_path fish_function_path
  __fish_fix_path fish_complete_path

  if cygwin?
    # fish_help_browser overrides the browser that may be defined by $BROWSER.
    # The variable may be an array containing a browser name plus options.
    # N.B. This must be a GUI app; fish will use cygstart(1) to launch it.
    set -g fish_help_browser "$LOCALAPPDATA\\Mozilla Firefox\\firefox.exe"
  end

  # See functions/update_lastpwd.fish
  if test -f ~/.lastpwd
    cd (cat ~/.lastpwd)
  end
end
