#!/usr/bin/env fish

# Based on: https://github.com/MikeMcQuaid/dotfiles/blob/d72d627/script/install-vscode-extensions

# To update the extensions file with the current loadout:
#   code --list-extensions > ~/.config/Code/User/extensions

if not command -sq code
  echo >&2 "error: VS Code not found"
  exit 1
end

set desired_extensions (cat ~/.config/Code/User/extensions)
set installed_extensions (code --list-extensions)

function verbose
  echo -s (set_color blue) "$argv[1]:" (set_color normal) " $argv[2]"
end

for extension in $desired_extensions
  if contains $extension $installed_extensions
    verbose "already installed" $extension #debug
    continue
  else
    verbose "installing" $extension #debug
    code --install-extension $extension
  end
end

for extension in $installed_extensions
  if not contains $extension $desired_extensions
    verbose "uninstalling" $extension #debug
    code --uninstall-extension $extension
  end
end