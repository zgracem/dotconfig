#!/usr/bin/env fish
# ----------------------------------------------------------------------------
# `$XDG_CONFIG_HOME/youtube-dl/config` must contain
#
#   --write-info-json
#   --exec /path/to/this-script.fish {}
#
# so that `youtube-dl` will create a JSON file of metadata alongside the video
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
    set -l dirname (dirname $video_filename)
    set -l basename (basename $video_filename | string split -r -m1 -f2 .)
    echo -n $dirname/$basename.info.json
end

# `jq` extracts the value of "webpage_url" from metadata in $json_file;
# `plutil` converts that string to a binary property list;
# `xxd` prints that binary plist as plain (-p) uppercase (-u) hex bytes;
# `string join` removes newlines.
function binary_plist_url -a json_file
    plutil -convert binary1 -o - (jq .webpage_url $json_file | psub) \
    | xxd -p -u \
    | string join ""
end

# Extracts the source URL from the metadata associated with $file;
# converts it to an ASCII hex representation of a binary representation of
# an entire XML property list representing that single string, because
# what do you mean NextStep isn't still 100% good decisions 20 years later...;
# then writes that string to $file's Spotlight "WhereFrom" attribute.
function set_wherefrom -a file
    set -l metadata_file (metadata_filename $file)
    set -l hex (binary_plist_url $metadata_file)
    or bail "failed to process: $metadata_file"

    set -l attr com.apple.metadata:kMDItemWhereFroms
    xattr -wx $attr $hex $file
    or bail "xattr failed to set $attr to `$hex`"
end

# Creates a string from the current UNIX epoch, the name of the application,
# and a new UUID, and applies it to $file to set its quarantine attribute.
function set_quarantine_timestamp -a file
    set -l metadata (printf "0081;%x;youtube-dl;%s" (date +%s) (uuidgen))

    set -l attr com.apple.quarantine
    xattr -w $attr $metadata $video_file
    or bail "xattr failed to set $attr to `$metadata`"
end

# ----------------------------------------------------------------------------
# main()
# ----------------------------------------------------------------------------

set_quarantine_timestamp $video_file
set_wherefrom $video_file
