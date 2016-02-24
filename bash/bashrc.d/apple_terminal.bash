[[ $TERM_PROGRAM == Apple_Terminal ]] || return

# disable save/restore in El Capitan Terminal.app
if [[ -n $TERM_SESSION_ID ]]; then
    export SHELL_SESSION_HISTORY=0

    unset -f update_terminal_cwd shell_session_{save_user_state,history_allowed,history_enable,history_check,save_history,save,delete_expired,update}
    
    if [[ ! -e ~/.bash_sessions_disable ]]; then
        command cp ~/.config/skel/.bash_sessions_disable "$HOME" \
            || command touch ~/.bash_sessions_disable
    fi &>/dev/null
else
    return 0
fi
