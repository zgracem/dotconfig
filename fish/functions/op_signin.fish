function op_signin --description "Sign into 1Password's CLI tool"
  if set -q OP_SESSION_my; and test "$argv[1]" != "--force"
    echo "already signed in, use --force to reauthenticate"
    return
  end
  # Vars defined in ~/.private/environment.d/1password.sh
  set -gx OP_SESSION_my (eval op signin my $OP_ACCOUNT $OP_SECRET --raw)
end
