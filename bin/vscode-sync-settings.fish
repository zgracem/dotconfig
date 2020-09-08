#!/usr/bin/env fish

# This script uses jq <https://github.com/stedolan/jq> to concatenate cross-
# platform VS Code preference with those settings specific to my proxy-bound,
# admin-less Windows 10 work machine.
#
# It can also be run on macOS to set up links between VS Code's folder under
# ~/Library/Application Support and my synced settings in ~/Dropbox.

set --global config_dir ~/.config/Code/User
set --global win_config_dir $config_dir/windows/Code/User
set --global app_data (cygpath -au "$APPDATA/Code/User")

if not test -d $app_data
  echo >&2 "error: not found:" $app_data
  exit 1
end

function merge_windows_settings
  set --local base_settings $config_dir/settings.json
  set --local win_settings $win_config_dir/settings.json

  set --local win_json (jq --compact-output --join-output '.' $win_settings)
  or exit

  set --local jq_filter $win_config_dir/filter_macos_settings.jq

  jq ". + $win_json" $base_settings \
  | jq -L $win_config_dir --from-file $jq_filter
end

function merge_proxy_settings
  set --local proxy "proxy:8080"
  set --local creds (string lower $USER)':\\($pw|rtrimstr("\n"))'
  set --local proxy_settings '{"http.proxy": "http://'$creds'@'$proxy'/"}'

  jq --sort-keys --rawfile pw ~/.p ". + $proxy_settings"
end

switch (uname -s)
case 'CYGWIN*'
  ### sync settings: merge and overwrite
  if not command -sq jq
    echo >&2 "error: jq not found"
    exit 127
  end

  if test -r ~/.p
    merge_windows_settings | merge_proxy_settings
  else
    merge_windows_settings
  end > $app_data/settings.json

  ### sync keybindings: overwrite
  command cp -af $config_dir/keybindings.json $app_data

  ### sync snippets: create a symlink/directory junction if one doesn't exist
  if not test -e $app_data/snippets
    cmd /C mklink /J (cygpath -aw $app_data/snippets) (cygpath -aw $config_dir/snippets)
  end

case 'Darwin'
  if not command -sq gdate
    echo >&2 "error: GNU date(1) not found"
    exit 127
  end

  set user_dir "$HOME/Library/Application Support/Code/User"

  if not test -L $user_dir/settings.json
    mkdir -p $user_dir
    if test -f $user_dir/settings.json
      set --local timestamp (printf '%x' (gdate +%y%m%d%H%M%S%N | string sub -l16))
      mv $user_dir/settings.json $user_dir/settings~$timestamp.json
    end

    ln -sf $config_dir/settings.json $user_dir
    ln -sf $config_dir/keybindings.json $user_dir
    ln -sf $config_dir/snippets $user_dir
  end
end
