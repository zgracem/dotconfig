#!/usr/bin/env bash

export APPSUPPORT="$HOME/Library/Application Support"
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}

function symlink()
{
    local target="$1"
    local link_dir="$APPSUPPORT/$2"
    local symlink="$link_dir/$(basename "$target")"
    if [[ -L $symlink ]]; then
        echo >&2 "symlink exists! $symlink"
        return
    elif [[ -e $symlink ]]; then
        echo >&2 "existing path is not a symlink! $symlink"
        return 1
    else
        ln -sv "$target" "$link_dir/"
    fi
}

symlink "$XDG_CONFIG_HOME/minecraft/options.txt" minecraft

# killall -v "Sublime Merge"
symlink "$HOME/.private/smerge/License.sublime_license" "Sublime Merge/Local"
symlink "$XDG_CONFIG_HOME/smerge/Commit Message.sublime-settings" "Sublime Merge/Packages/User"
symlink "$XDG_CONFIG_HOME/smerge/Diff.sublime-settings" "Sublime Merge/Packages/User"
symlink "$XDG_CONFIG_HOME/smerge/Preferences.sublime-settings" "Sublime Merge/Packages/User"

# killall -v "Sublime Text 3"
symlink "$XDG_CONFIG_HOME/st3/Packages/User" "Sublime Text 3/Packages"

# killall -v "Visual Studio Code"
symlink "$XDG_CONFIG_HOME/Code/User/snippets" "Code/User"
symlink "$XDG_CONFIG_HOME/Code/User/keybindings.json" "Code/User"
symlink "$XDG_CONFIG_HOME/Code/User/settings.json" "Code/User"
