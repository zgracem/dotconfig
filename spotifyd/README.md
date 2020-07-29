# `spotifyd`

```sh
# Setup:
brew install spotifyd
mkdir -p $HOME/Library/Caches/rustlang.spotifyd
ln -s $XDG_CONFIG_HOME/spotifyd/rustlang.spotifyd.plist $HOME/Library/LaunchAgents
launchctl load -w $HOME/Library/LaunchAgents/rustlang.spotifyd.plist
launchctl start $HOME/Library/LaunchAgents/rustlang.spotifyd.plist
```
