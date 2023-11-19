# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

if fish-is-older-than 3.1
    begin
        echo -e '\e[1;7;91m'
        echo "*** These configuration files should not run on fish $version ***"
        set_color normal
    end >&2
    kill $fish_pid
end

# setup environment, including PATH and friends
source "$__fish_config_dir/env.fish"

# stop here if not an interactive session
status is-interactive; or exit

# function subdirectories
set -p fish_function_path "$__fish_config_dir/functions/_debug"
set -p fish_function_path "$__fish_config_dir/functions/_wrappers"
set -p fish_function_path "$__fish_config_dir/functions"
set -p fish_function_path "$HOME/.private/fish/functions"

# load private and per-machine configuration if available
set -ga fish_package_path "$XDG_CONFIG_HOME/local/$hostname/fish"
set -ga fish_package_path "$HOME/.private/fish"

# activate custom prompt
set -p fish_package_path "$__fish_config_dir/prompt"

# personal minimal package manager for fish
set fish_package_path (path filter -d $fish_package_path)
source "$__fish_config_dir/packages.fish"

# setup keybindings
set -p fish_function_path "$__fish_config_dir/bindings"
source "$__fish_config_dir/bindings.fish"

# source vendor completions
set -p fish_complete_path "$HOME/opt/etc/fish/completions"

# remove duplicate & nonexistent directories
set fish_function_path (path filter -d $fish_function_path | un1q)
set fish_complete_path (path filter -d $fish_complete_path | un1q)

# setup abbreviations
source "$__fish_config_dir/abbreviations.fish"

# setup colours
source "$__fish_config_dir/colours.fish"

if is-cygwin
    # fish_help_browser overrides the browser that may be defined by $BROWSER.
    # The variable may be an array containing a browser name plus options.
    # N.B. This must be a GUI app; fish will use cygstart(1) to launch it.
    set -g fish_help_browser "$PROGRAMFILES\\Mozilla Firefox\\firefox.exe"
end
