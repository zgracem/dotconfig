notify()
{
  local title=${HOSTNAME%%.*}
  local message="$*"

  if _inPath pushover; then
    pushover -k "$PUSHOVER_APP_TOKEN" -u "$PUSHOVER_USER_KEY" \
      -t "$title" \
      "$message"
  else
    curl -sS \
      --form-string "token=$PUSHOVER_APP_TOKEN" \
      --form-string "user=$PUSHOVER_USER_KEY" \
      --form-string "title=$title" \
      --form-string "message=$message" \
      "https://api.pushover.net/1/messages.json" \
      >/dev/null
  fi
}
