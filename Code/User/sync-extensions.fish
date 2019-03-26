#!/usr/bin/env fish

# Based on: https://github.com/MikeMcQuaid/dotfiles/blob/d72d627/script/install-vscode-extensions

if not command -sq code
  echo >&2 "error: VS Code not found"
  exit 1
end

set desired_extensions (cat $XDG_CONFIG_HOME/Code/User/extensions)
set installed_extensions (code --list-extensions)

for extension in $desired_extensions
  if contains $extension $installed_extensions
    set_color blue; echo "already installed: $extension"; set_color normal #debug
    continue
  else
    set_color blue; echo "installing: $extension"; set_color normal #debug
    code --install-extension $extension
  end
end

for extension in $installed_extensions
  if not contains $extension $desired_extensions
    set_color blue; echo "uninstalling: $extension"; set_color normal #debug
    code --uninstall-extension $extension
  end
end
