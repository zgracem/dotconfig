# -----------------------------------------------------------------------------
# ~/.bash_profile
# Executed by bash(1) for login shells
# -----------------------------------------------------------------------------

# Allow testing of array variable as a whole
# shellcheck disable=SC2128
if test "$BASH_VERSINFO"; then
  # bash >2.0, so source .bashrc
  # shellcheck source=./.bashrc
  [[ -r $HOME/.bashrc ]] && . "$HOME/.bashrc"
else
  # bash <2.0, abort
  return
fi
