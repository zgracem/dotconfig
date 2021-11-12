# -----------------------------------------------------------------------------
# $XDG_CONFIG_HOME/yt-dlp/config            <https://github.com/yt-dlp/yt-dlp>
# vim:ft=sh
# shellcheck disable=SC2215
# Generated from $XDG_CONFIG_HOME/yt-dlp/config.m4
# -----------------------------------------------------------------------------
# general options
# -----------------------------------------------------------------------------

# bypass geographic restriction via faking X-Forwarded-For HTTP header
--geo-bypass

# ----------------------------------------------------------------------------
# youtube-dl compatibility options
# ----------------------------------------------------------------------------

# prevent downloading live chat as a subtitle track
--compat-options no-live-chat

# prevent listing unavailable videos for YouTube playlists
--compat-options no-youtube-unavailable-videos

# use AtomicParsley to embed thumbnails instead of mutagen
--compat-options embed-thumbnail-atomicparsley

# prevent removing fields such as filenames from infojson
--compat-options no-clean-infojson

# -----------------------------------------------------------------------------
# filesystem options
# -----------------------------------------------------------------------------

# output filename template
--output "%(title)s.%(ext)s"

# do not overwrite files
--no-overwrites

# do not fetch comments unless it can be done quickly
--no-write-comments

# -----------------------------------------------------------------------------
# verbosity/simulation options
# -----------------------------------------------------------------------------

# display progress in console titlebar
--console-title

# -----------------------------------------------------------------------------
# workarounds
# -----------------------------------------------------------------------------

# disguise user agent
--user-agent "_USER_AGENT_"

# -----------------------------------------------------------------------------
# video format options
# -----------------------------------------------------------------------------

# get best MP4 video when possible
--format bestvideo*[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/bestvideo*+bestaudio/best

# do not download the DASH manifest on YouTube videos
--no-youtube-include-dash-manifest

# -----------------------------------------------------------------------------
# post-processing options
# -----------------------------------------------------------------------------

# location of the ffmpeg binary
--ffmpeg-location /usr/local/bin/ffmpeg

# embed thumbnail in the video as cover art
--embed-thumbnail

# run custom post-processing script to add metadata etc.
--write-info-json
--exec "_HOME_/.config/yt-dlp/postexec.fish {}"
