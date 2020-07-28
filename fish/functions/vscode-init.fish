function vscode-init --description 'Initialize directory for use with VS Code'
  set -l dir $PWD/.vscode
  set -q argv[1]; and set dir $argv[1]/.vscode

  mkdir -p "$dir"

  if not test -f "$dir/settings.json"
    echo '{}' > "$dir/settings.json"
  end

  if not test -f "$dir/extensions.json"
    jq --null-input '.recommendations=[]' > "$dir/extensions.json"
  end
end
