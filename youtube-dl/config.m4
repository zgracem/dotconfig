# -----------------------------------------------------------------------------
# ~/.config/youtube-dl/config          <https://ytdl-org.github.io/youtube-dl/>
# vim:ft=sh
# shellcheck disable=SC2215
# Generated from ~/.config/.src/youtube-dl.m4
# -----------------------------------------------------------------------------
# general options
# -----------------------------------------------------------------------------

# continue on download errors, e.g. to skip unavailable videos in a playlist
--ignore-errors

# bypass geographic restriction via faking X-Forwarded-For HTTP header
--geo-bypass

# -----------------------------------------------------------------------------
# filesystem options
# -----------------------------------------------------------------------------

# output filename template
--output "%(title)s.%(ext)s"

# do not overwrite files
--no-overwrites

# -----------------------------------------------------------------------------
# verbosity/simulation options
# -----------------------------------------------------------------------------

# display progress in console titlebar
--console-title

# do NOT contact the youtube-dl server for debugging
--no-call-home

# -----------------------------------------------------------------------------
# workarounds
# -----------------------------------------------------------------------------

# disguise user agent
--user-agent "_USER_AGENT_"

# -----------------------------------------------------------------------------
# video format options
# -----------------------------------------------------------------------------

# get best mp4 quality
--format bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio/best

# do not download the DASH manifest on YouTube videos
--youtube-skip-dash-manifest

# -----------------------------------------------------------------------------
# post-processing options
# -----------------------------------------------------------------------------

# prefer avconv over ffmpeg for running the postprocessors
--prefer-avconv

# run custom post-processing script to add metadata etc.
--write-info-json
--exec "_HOME_/.config/youtube-dl/postexec.fish {}"
