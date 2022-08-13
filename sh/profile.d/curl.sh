curl()
{ # prefers Homebrew's cURL if present
  PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH" command curl "$@"
}
