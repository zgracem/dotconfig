_inPath keychain || return

### ZGM disabled 2016-10-12 -- I don't use GnuPG right now
# export GPG_TTY="$(tty)"

if [[ -z $SSH_AGENT_PID ]]; then
  keychain_dir="$XDG_RUNTIME_DIR"
  [[ -d $keychain_dir ]] || mkdir -pv "$keychain_dir"

  [[ :$SHELLOPTS: =~ :noclobber: ]] || trap 'set -o noclobber; trap - RETURN;' RETURN
  set +o noclobber

  if keychain_env=$(keychain --agents ssh \
                             --dir "$keychain_dir" \
                             --ignore-missing \
                             --inherit any \
                             --quick --quiet \
                             --eval \
                             id_rsa)
  then
    eval "$keychain_env"
  fi
  
  unset -v keychain_dir keychain_env
fi
