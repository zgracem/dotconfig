curl()
{ # prefers Homebrew's cURL if present
  PATH="/usr/local/opt/curl/bin:$PATH" command curl "$@"
}
