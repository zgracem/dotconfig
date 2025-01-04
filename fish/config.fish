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

# launch 4.0 beta if present
set -l fish_beta $XDG_BIN_HOME/fish
string match -v -q (status fish-path) (path resolve $fish_beta)
and test -x $fish_beta
and exec $fish_beta

# function subdirectories
set -p fish_function_path "$__fish_config_dir/functions/_wrappers"
set -p fish_function_path "$__fish_config_dir/functions"
set -p fish_function_path "$HOME/.private/fish/functions"

# load vendor & user completions
set -p fish_complete_path "$HOMEBREW_PREFIX/opt/fish/share/fish/completions"
set -p fish_complete_path "$XDG_DATA_HOME/fish/vendor_completions.d"
set -p fish_complete_path "$__fish_config_dir/completions"

# set up per-machine config directory
set -l short_host (string replace -r '\.local$' '' $hostname)
set -l local_config_dir (path resolve "$XDG_CONFIG_HOME/local/$short_host")
set -l local_config_link "$XDG_DATA_HOME/../config"
if path is -d $local_config_dir
    if not path is -l $local_config_link
        ln -sv $local_config_dir $local_config_link
    end
end

# load private and per-machine configuration if available
set -ga fish_package_path "$local_config_dir/fish"
set -ga fish_package_path "$HOME/.private/fish"

# activate custom prompt
set -p fish_package_path "$__fish_config_dir/prompt"

# personal minimal package manager for fish
set fish_package_path (path filter -d $fish_package_path)
source "$__fish_config_dir/packages.fish"

# remove duplicate & nonexistent directories
set fish_function_path (path filter -d $fish_function_path | un1q)
set fish_complete_path (path filter -d $fish_complete_path | un1q)

# setup abbreviations
source "$__fish_config_dir/abbreviations.fish"

# setup colours
source "$__fish_config_dir/colours.fish"
