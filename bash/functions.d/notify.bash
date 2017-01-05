notify()
{
  curl -sS \
    --form-string "user=$PUSHOVER_USER_KEY" \
    --form-string "token=$PUSHOVER_APP_TOKEN" \
    --form-string "title=${HOSTNAME%%.*}" \
    --form-string "message=$*" \
    "https://api.pushover.net/1/messages.json" \
    >/dev/null &
}
