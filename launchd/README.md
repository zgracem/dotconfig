# ~/.config/launchd

The files in this directory can establish arbitrary user-level Launch Agents in
macOS from simple YAML files.

Currently this is only used to make certain environment variables available to
GUI apps by running `setenv.fish` at login.

```sh
make -C $XDG_CONFIG_HOME/launchd install
```
