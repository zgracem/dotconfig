function rootme --description 'Temporarily become the root user'
  # rename window if applicable
  in-tmux; and tmux rename-window sudo 2>/dev/null

  # switch user
  sudo SHELL=(type -P bash) -s

  # restore window name
  in-tmux; and tmux set-window-option automatic-rename on 2>/dev/null
end
