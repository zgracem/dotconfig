#!/usr/bin/env fish

# This script uses jq <https://github.com/stedolan/jq> to concatenate cross-
# platform settings with those specific to my proxy-bound, admin-less Windows 10
# machine at work.

set config_dir ~/.config/Code/User

switch (uname -s)
case 'CYGWIN*'
  if not command -sq jq
    echo >&2 "error: jq not found"
    exit 127
  end

  set dir (cygpath -au "$APPDATA/Code/User")

  ### sync settings

  set base_settings (cygpath -aw $config_dir/settings.json)
  set more_settings (cygpath -aw $config_dir/windows/Code/User/settings.json)

  if not test -d $dir
    echo >&2 "error: not found:" $dir
    exit 1
  end

  set more_json (jq --compact-output --join-output '.' $more_settings)

  jq --sort-keys ". + $more_json" $base_settings > $dir/settings.json

  ### sync keybindings

  command cp -af $config_dir/keybindings.json $dir

  ### sync snippets

  if not test -e $dir/snippets
    cmd /C mklink /J (cygpath -aw $dir/snippets) (cygpath -aw $config_dir/snippets)
  end

case 'Darwin'
  set dir "$HOME/Library/Application Support/Code/User"

  if not test -L $dir/settings.json
    mkdir -p $dir
    test -f $dir/settings.json; and mv $dir/settings.json $dir/settings.json~original
    ln -sf $config_dir/settings.json $dir
    ln -sf $config_dir/keybindings.json $dir
    ln -sf $config_dir/snippets $dir
  end
end
