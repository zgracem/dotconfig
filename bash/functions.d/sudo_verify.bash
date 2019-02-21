sudo_verify()
{ #: - verify sudo privileges w/out escalating
  #: = true/false
  command -v sudo >/dev/null || return 1
  # TODO: check admin status on Cygwin

  if sudo -v; then  # verified...
    sudo -k         # ...revoke sudo privileges...
    return 0        # ...success!
  else              # user could not verify...
    return 1        # ...failure :(
  fi
}
