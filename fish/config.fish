# -----------------------------------------------------------------------------
# ~/.config/fish/config.fish
# -----------------------------------------------------------------------------

if fish-is-older-than 3.4
    begin
        set_color brred --reverse
        echo "*** These configuration files should not run on fish $version ***"
        set_color normal
    end >&2
    exit 1
end

# setup environment
source "$__fish_config_dir/__env.fish"

# setup PATH and friends
source "$__fish_config_dir/paths.fish"

# stop here if not an interactive session
status is-interactive; or exit

# function subdirectories
set -p fish_function_path "$__fish_config_dir/functions/_debug"
set -p fish_function_path "$__fish_config_dir/functions/_wrappers"
set -p fish_function_path "$__fish_config_dir/functions"
set -p fish_function_path "$HOME/.private/fish/functions"

# load private and per-machine configuration if available
set -g fish_package_path "$HOME/.local/config/fish" "$HOME/.private/fish"

# personal minimal package manager for fish
source "$__fish_config_dir/packages.fish"

# setup abbreviations
source "$__fish_config_dir/aliases.fish"

# setup keybindings
source "$__fish_config_dir/bindings.fish"

# setup colours
source "$__fish_config_dir/colours.fish"

# activate custom prompt
set -p fish_function_path "$__fish_config_dir/prompt"

# source vendor completions
set -p fish_complete_path "$HOME/opt/etc/fish/completions"
set -p fish_complete_path "$HOME/VS/www/vsdotcom/etc/fish/completions"

# remove duplicate & nonexistent directories
fix-path fish_function_path
fix-path fish_complete_path

if is-cygwin
    # fish_help_browser overrides the browser that may be defined by $BROWSER.
    # The variable may be an array containing a browser name plus options.
    # N.B. This must be a GUI app; fish will use cygstart(1) to launch it.
    set -g fish_help_browser "$LOCALAPPDATA\\Mozilla Firefox\\firefox.exe"
end

# See conf.d/update-lastpwd.fish
if status is-interactive; and not string match -q $TERM_PROGRAM vscode; and path is -f $__fish_user_data_dir/last_pwd
    read -l dir <$__fish_user_data_dir/last_pwd
    path is -d $dir; and cd $dir
end

# VS Code shell integration (experimental)
set -l VSCODE ~/GitHub/vscode/src
. "$VSCODE/vs/workbench/contrib/terminal/browser/media/shellIntegration.fish"
