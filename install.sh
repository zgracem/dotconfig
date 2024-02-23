#!/usr/bin/env bash

# ⚠️ MANUAL: Install Xcode from the App Store
if [[ ! -e /Applications/Xcode.app ]]; then
    echo "fatal error: Xcode not found" >&2
    exit 1
fi

# AUTO: Install Xcode command-line tools
if [[ ! -e /Library/Developer/CommandLineTools ]]; then
    xcode-select --install || exit
fi

## AUTO: Set important environment variable
#SDKROOT=$(xcrun --sdk macosx --show-sdk-path) || exit
#export SDKROOT

# ⚠️ MANUAL: Install Dropbox.app & complete first sync
export DROPBOX=$HOME/Dropbox
if [[ ! -d $DROPBOX/.config ]]; then
    echo "fatal error: Dropbox not found" >&2
    exit 1
fi

# AUTO: Link ~/.config and ~/.private
export XDG_CONFIG_HOME=$HOME/.config
ln -sfv "Dropbox/.config" "$XDG_CONFIG_HOME" || exit
ln -sfv "Dropbox/.private" "$HOME/.private" || exit

# AUTO: Complete installation
cd "$XDG_CONFIG_HOME" || exit

# ⚠️ MANUAL: Other installation and setup steps (not exhaustive)
make -C homebrew        # install Homebrew
./macos/appsupport.sh   # create symlinks in ~/Library/Application Support
