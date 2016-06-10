# fpp
# https://github.com/facebook/PathPicker

_inPath fpp || return

export FPP_DIR=~/var/spool/fpp

# TODO: remove later
[[ -d $FPP_DIR ]] || mkdir -p "$FPP_DIR"
[[ -d ~/.fpp ]] && rm -rf ~/.fpp &>/dev/null

# Don't wait for fpp if VISUAL is something like `subl --wait`
export FPP_EDITOR=${VISUAL%%?( -)-wait}

# -----------------------------------------------------------------------------
# tmux integration
# Based on: https://github.com/tmux-plugins/tmux-fpp
# -----------------------------------------------------------------------------

_inTmux || return

fpp_key=$(tmux show-option -gvq "@fpp_key") \
  || fpp_key="f"

fpp_buffer="$FPP_DIR/tmux-buffer"
fpp_log="$HOME/var/log/fpp.sh.log"

tmux bind-key "$fpp_key" \
  capture-pane -J \\\; \
  save-buffer "$fpp_buffer" \\\; delete-buffer \\\; \
  new-window -n fpp -c "#{pane_current_path}" \
    "sh -c 'fpp < \"$fpp_buffer\" 2>>\"$fpp_log\"; rm \"$fpp_buffer\"'"

unset -v fpp_key fpp_buffer fpp_log
