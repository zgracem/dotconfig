alias tt='tmux attach 2>&- || tmux -2 new-session'
#                 │                 │ └─ create new session
#                 │                 └─── 256-colour mode
#                 └───────────────────── attach to session if it exists
