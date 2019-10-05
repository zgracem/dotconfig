function vscode-init --description 'Initialize directory for use with VS Code'
  set -l dir $PWD
  set -q argv[1]; and set dir $argv[1]

  mkdir -p "$dir/.vscode"

  if not test -f "$dir/.vscode/settings.json"
    echo '{}' > "$dir/.vscode/settings.json"
  end
end
