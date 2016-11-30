# -----------------------------------------------------------------------------
# ~/.config/bash/profile.bash                                   ~/.bash_profile
# executed by bash(1) for login shells
# -----------------------------------------------------------------------------

if test "$BASH_VERSINFO"; then
  # bash >2.0, so source .bashrc
  [[ -r $HOME/.bashrc ]] && . "$HOME/.bashrc"
else
  # bash <2.0, abort
  return
fi
