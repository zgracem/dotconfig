# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

if fish-is-older-than 3.1
    begin
        echo -e '\e[1;7;91m'
        echo "*** These configuration files should not run on fish $version ***"
        echo -e '\e[0m'
    end >&2
    exit 127
end

# setup environment, including PATH and friends
source "$__fish_config_dir/env.fish"

# stop here if not an interactive session
status is-interactive; or return

# function subdirectories
set -p fish_function_path "$__fish_config_dir/functions/_debug"
set -p fish_function_path "$__fish_config_dir/functions/_wrappers"
set -p fish_function_path "$__fish_config_dir/functions"
set -p fish_function_path "$HOME/.private/fish/functions"

# load user completions
set -p fish_complete_path "$__fish_config_dir/completions"

# load private and per-machine configuration if available
set -l short_host (string replace -r '\.local$' '' $hostname)
set -ga fish_package_path "$XDG_CONFIG_HOME/local/$short_host/fish"
set -ga fish_package_path "$HOME/.private/fish"

# activate custom prompt
set -p fish_package_path "$__fish_config_dir/prompt"

# personal minimal package manager for fish
set fish_package_path (path filter -d $fish_package_path)
source "$__fish_config_dir/packages.fish"

# setup keybindings
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
