#!/usr/bin/env fish
# ----------------------------------------------------------------------------
# `$XDG_CONFIG_HOME/yt-dlp/config` must contain
#
#   --write-info-json
#   --exec /path/to/this-script.fish {}
#
# so that `yt-dlp` will create a JSON file of metadata alongside the video
# and call this script with the downloaded video as the only argument.
# ----------------------------------------------------------------------------

function bail -d "Print an error message and exit" -a message code
    test -n "$code"; or set -l code 1

    echo >&2 $message
    exit $code
end

#  in: /path/to/video.mp4
# out: /path/to/video.info.json
function metadata_filename -a video_filename
    set -l basename (string split -r -m1 -f1 . $video_filename)
    set -l metadata_file $basename.info.json

    if test -f $metadata_file
        echo -n $basename.info.json
    else
        bail "metadata not found: $metadata_file"
    end
end

function webpage_url -a json_file
    jq .webpage_url $json_file
end

# `jq` extracts the value of "webpage_url" from metadata in $json_file;
# `plutil` converts that string to a binary property list;
# `xxd` prints that binary plist as `-p`lain `-u`ppercase hex bytes;
# `string join` removes newlines.
function binary_plist_url -a json_file
    plutil -convert binary1 -o - (webpage_url $json_file | psub) \
    | xxd -p -u \
    | string join ""
end

# Extracts the source URL from the metadata associated with $video_file;
# converts it to an ASCII hex representation of a binary representation
# of an entire XML property list representing that single string
# (because NextStep is still 100% good decisions 20 years later...);
# then writes that string to $video_file's "WhereFrom" Spotlight attribute.
function set_wherefrom -a video_file metadata_file
    test -n "$metadata_file"
    or set -l metadata_file (metadata_filename $video_file)

    set -l url (webpage_url $metadata_file)
    or bail "failed to extract URL fron $metadata_file"

    echo "url = $url" #debug

    set -l hex_url (binary_plist_url $metadata_file)
    or bail "failed to process: $metadata_file"

    echo "hex = $hex_url" #debug

    set -l attr com.apple.metadata:kMDItemWhereFroms

    xattr -wx $attr $hex_url $video_file
    or bail "xattr failed to set $attr to `$hex_url`"

    echo "att = $attr" #debug
end

# Creates a string from the current UNIX epoch, the name of the application,
# and a new UUID, and applies it to $file to set its quarantine attribute.
function set_quarantine_timestamp -a file
    set -l hex_epoch (printf "%x" (date +%s))
    set -l app yt-dlp
    set -l uuid (uuidgen)

    set -l timestamp_parts 0081 $hex_epoch $app $uuid
    set -l metadata (string join \; $timestamp_parts)

    echo "now = $metadata" #debug

    set -l attr com.apple.quarantine
    xattr -w $attr $metadata $file
    or bail "xattr failed to set $attr to `$metadata`"

    echo "att = $attr" #debug
end

# ----------------------------------------------------------------------------
# main()
# ----------------------------------------------------------------------------

set_quarantine_timestamp $argv
set_wherefrom $argv
