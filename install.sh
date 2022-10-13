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

# AUTO: Set important environment variable
SDKROOT=$(xcrun --sdk macosx --show-sdk-path) || exit
export SDKROOT

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

make homebrew       # install Homebrew
make -C etc shells  # setup /etc/shells and `chsh -s /usr/local/bin/fish`
make appsupport     # create symlinks from ~/Library/Application Support to ~/.config
make -C etc dnsmasq # install config for local *.test TLD
make user-agent     # rebuild files like .wgetrc with a fake user-agent
make all            # everything else
