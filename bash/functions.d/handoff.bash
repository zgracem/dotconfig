handoff()
{
  local url="$1"

  curl -sS \
    --form-string "user=$PUSHOVER_USER_KEY" \
    --form-string "token=$PUSHOVER_APP_TOKEN" \
    --form-string "device=zPhone" \
    --form-string "title=URL from ${HOSTNAME%%.*}" \
    --form-string "url=$url" \
    --form-string "message=$url" \
    "https://api.pushover.net/1/messages.json" \
    >/dev/null &
}
