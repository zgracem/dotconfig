handoff()
{
  local url="$1"
  local title="URL from ${HOSTNAME%%.*}"
  local device="zPhone"
  local message="$url"

  if _inPath pushover; then
    pushover -k "$PUSHOVER_APP_TOKEN" -u "$PUSHOVER_USER_KEY" \
      -d "$device" -t "$title" -U "$url" \
      "$message"
  else
    curl -sS \
        --form-string "user=$PUSHOVER_USER_KEY" \
        --form-string "token=$PUSHOVER_APP_TOKEN" \
        --form-string "device=$device" \
        --form-string "title=$title" \
        --form-string "url=$url" \
        --form-string "message=$message" \
        "https://api.pushover.net/1/messages.json" \
        >/dev/null
  fi  
}
