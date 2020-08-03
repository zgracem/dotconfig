# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

if test (fish_version major) -le 2
  begin
    set_color brred --reverse
    echo "*** This configuration file cannot run on fish $version ***"
    set_color normal
  end >&2
  exit 1
end

# setup PATH and friends
source "$__fish_config_dir/paths.fish"

# function subdirectories
for dir in $__fish_config_dir/functions{,/**/} ~/.private/fish/functions
  set -p fish_function_path (string trim --right --chars=/ $dir)
end

# load private and per-machine configuration if available
set -g fish_package_path ~/.local/config/fish ~/.private/fish

# personal minimal package manager for fish
source "$__fish_config_dir/packages.fish"

if status is-interactive
  # setup abbreviations
  source "$__fish_config_dir/aliases.fish"

  # setup colours
  source "$__fish_config_dir/colours.fish"

  # activate custom prompt
  set -p fish_function_path "$__fish_config_dir/prompt"

  # source vendor completions
  set -p fish_complete_path "$HOME/opt/etc/fish/completions"
end

# remove duplicate & nonexistent directories
_fix_path fish_function_path
_fix_path fish_complete_path

if is-cygwin
  # fish_help_browser overrides the browser that may be defined by $BROWSER.
  # The variable may be an array containing a browser name plus options.
  # N.B. This must be a GUI app; fish will use cygstart(1) to launch it.
  set -g fish_help_browser "$LOCALAPPDATA\\Mozilla Firefox\\firefox.exe"
end

# See conf.d/_update_lastpwd.fish
if test -f ~/.lastpwd; and status is-interactive
  set -l dir (cat ~/.lastpwd)
  test -d "$dir"; and cd "$dir"
end
