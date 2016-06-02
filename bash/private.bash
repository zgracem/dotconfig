# -----------------------------------------------------------------------------
# ~/.config/bash/private.bash
# you should not be reading this
# -----------------------------------------------------------------------------

### * ZGM removed `export` 2015-09-29 for tidiness -- add back as needed

# -----------------------------------------------------------------------------
# countdown
# -----------------------------------------------------------------------------

# export countTo='2016-05-26 23:54 -0600'

if [[ -x $dir_scripts/countdown.sh && -n $countTo ]]; then
  c() {
    local output

    printf -v output "%b " "$esc_red\xe2\x99\xa5$esc_reset"
    output+=$("$dir_scripts/countdown.sh" "$@" "$countTo")

    echo "$output"
  }
  cs() { c -s; }
  cl() { c -l; }
  # alias  c="$dir_scripts/countdown.sh '${countTo}'"
  # alias cl="$dir_scripts/countdown.sh -l '${countTo}'"
  # alias cs="$dir_scripts/countdown.sh -s '${countTo}'"
fi

# -----------------------------------------------------------------------------
# API tokens
# -----------------------------------------------------------------------------

# tinypng
export TINYPNG_API_TOKEN='ammbxouG1p2YXPIRw7_84YywEfiIY0HH'

# Homebrew
export GITHUB_API_TOKEN='3b1670b5c75f887e0607728cdc61b98a8346e6ee'
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_API_TOKEN

# Internet Archive (for `ia`)
IAS3_ACCESS_KEY='rn1WGIhRj7BFyuHa' # *
IAS3_SECRET_KEY='aZIufeS71Luu3t2J' # *

# # Ignota AWS
# AWS_ACCESS_KEY='AKIAIMTIQMNFTHDPXLWA' # *
# AWS_SECRET_KEY='Y1UX2lwKigQdEMft9hTj' # and/or TdEJnZYuWWLnG6stzpS # *

# # Ignota Slack (for `slackcat`)
### ZGM disabled 2016-04-28 -- don't really use this
# export SLACK_TOKEN='xoxp-3350625726-3350641272-3362435597-4bde7f' # export for Ruby
# SLACK_CHANNEL='general' # *

# Google Search API (for `qg` function)
GOOGLE_API_KEY='AIzaSyDDdNG1YlQYcPprIOpnp3GlCBFxvjTACKo' # *
QG_ID='016874063210559347907:fmbcowz9zk8' # *

# Pinboard
export PINBOARD_API_KEY='zozo:E73A8AC9A04A730507E6'

# Dropbox SDK
DROPBOX_UID=236959
DROPBOX_RUBY_SDK_ACCESS_TOKEN='wuNg7KKqh_gAAAAAAAAYm_ixtXyvi5z7laA2SAEU1gi-AtI9YPTtTWAzBhVP1roU'

# -----------------------------------------------------------------------------

# # supplementary files
# if [[ -d $dir_config/bash/private.d ]]; then
#     for file in "$dir_config"/bash/private.d/*.bash; do
#         [[ -f $file ]] && . "$file"
#     done
# else
#     return 0
# fi
