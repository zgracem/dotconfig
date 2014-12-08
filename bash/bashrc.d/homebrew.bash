# Homebrew
# http://brew.sh/

_inPath brew || return

# print developer warnings
export HOMEBREW_DEVELOPER=true

# don't print beer emoji when logged in remotely
if [[ -n $SSH_CONNECTION ]]; then
    export HOMEBREW_NO_EMOJI=true
fi
