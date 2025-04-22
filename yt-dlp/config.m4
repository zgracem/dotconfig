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

# prevent removing fields such as filenames from infojson
--compat-options no-clean-infojson

# -----------------------------------------------------------------------------
# download options
# -----------------------------------------------------------------------------

# use aria2c for DASH(mpd) and HLS(m3u8) downloads
--downloader "dash,m3u8:aria2c"

# download multiple fragments of a dash/hlsnative video concurrently
--concurrent-fragments 2

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

# display progress bar
--progress

# -----------------------------------------------------------------------------
# workarounds
# -----------------------------------------------------------------------------

# disguise user agent
--user-agent "_USER_AGENT_"

# -----------------------------------------------------------------------------
# post-processing options
# -----------------------------------------------------------------------------

# run custom post-processing script to add metadata etc.
--write-info-json
--exec "_XDG_CONFIG_HOME_/yt-dlp/postexec.fish {}"
