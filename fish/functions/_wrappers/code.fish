if is-macos
  function code --description "Open Visual Studio Code"
    # Circumvent https://github.com/microsoft/vscode/issues/60579 if we're just
    # opening a file or directory and don't need command-line options.
    set -l cli_rx "--?[a-z-]+"
    if string match -rq -- $cli_rx $argv
      command code $argv
    else
      open -b com.microsoft.VSCode -- $argv
    end
  end
end
