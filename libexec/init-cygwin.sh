#!/usr/bin/env bash

export CYGAPPDATA=$(cygpath -au "$APPDATA")
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=$HOME/.config}

function symlink()
{
    local target="$1"
    local link_dir="$CYGAPPDATA/$2"
    local symlink="$link_dir/$(basename "$target")"
    mkdir -pv "$(dirname "$link_dir")"
    if [[ -L $symlink ]]; then
        ln -sfv "$target" "$link_dir/"
    elif [[ -e $symlink ]]; then
        echo >&2 "existing path is not a symlink! $symlink"
        return 1
    else
        ln -sv "$target" "$link_dir/"
    fi
}

symlink "$HOME/.private/smerge/Local/License.sublime_license" "Sublime Merge/Local"
symlink "$XDG_CONFIG_HOME/smerge/windows/Packages/User/Commit Message.sublime-settings" "Sublime Merge/Packages/User"
symlink "$XDG_CONFIG_HOME/smerge/Packages/User/Diff.sublime-settings" "Sublime Merge/Packages/User"
symlink "$XDG_CONFIG_HOME/smerge/windows/Packages/User/Preferences.sublime-settings" "Sublime Merge/Packages/User"

symlink "$XDG_CONFIG_HOME/st3/Packages/User" "Sublime Text 3/Packages"

symlink "$XDG_CONFIG_HOME/Code/User/windows/Code/User/settings.json" "Code/User"
