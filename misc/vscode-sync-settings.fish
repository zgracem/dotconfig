#!/usr/bin/env fish

# This script uses jq <https://github.com/stedolan/jq> to concatenate cross-
# platform settings with those specific to my proxy-bound, admin-less Windows
# machine at work.

if not string match -eq 'CYGWIN' (uname -s)
  echo >&2 "error: this script is for Windows only"
  exit 1
else if not command -sq jq
  echo >&2 "error: jq not found"
  exit 127
end

set output_dir (cygpath -au "$APPDATA/Code/User")

### sync settings

set base_settings ~/.config/Code/User/settings.json
set more_settings ~/.config/Code/User/settings.windows.json

if not test -d $output_dir
  echo >&2 "error: not found:" $output_dir
  exit 1
end

jq '. + '(jq -cj '.' $more_settings) $base_settings > $output_dir/settings.json

### sync keybindings

cp -af ~/.config/Code/User/keybindings.json $output_dir
