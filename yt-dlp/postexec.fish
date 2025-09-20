#!/usr/bin/env fish
# -----------------------------------------------------------------------------
# This script is called by `yt-dlp` when a download finishes, and adds media and
# filesystem metadata to the downloaded file.
#
# `$XDG_CONFIG_HOME/yt-dlp/config` must contain:
#
#   --write-info-json
#   --exec $XDG_CONFIG_HOME/yt-dlp/postexec.fish {}
#
# so that `yt-dlp` will create a JSON file of metadata alongside the video, and
# call this script with the downloaded video as the only argument.
# -----------------------------------------------------------------------------

function bail -d "Print an error message and exit" -a message code
    test -n "$code"; or set -l code 1

    echo >&2 $message
    exit $code
end

#  in: /path/to/video.mp4
# out: /path/to/video.info.json
function metadata_filename -a video_filename
    set -g metadata_file (path change-extension .info.json $video_filename)

    if path is -f $metadata_file
        echo -n $metadata_file
        set -q _flag_verbose; and echo >&2 "found metadata file: $metadata_file"
    else
        echo >&2 "metadata not found: $metadata_file"
        exit 1
    end
end

# `jq` extracts the value of "webpage_url" from metadata in $json_file;
# `plutil` converts that string to a binary property list;
# `xxd` prints that binary plist as `-p`lain `-u`ppercase hex bytes;
# `string join` removes newlines.
function binary_plist_url -a json_file
    plutil -convert binary1 -o - (jq .webpage_url $json_file | psub) \
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

    if not set -l url (jq .webpage_url $metadata_file)
        echo >&2 "failed to extract URL from $metadata_file"
        exit 1
    else if set -q _flag_verbose
        echo >&2 "extracted URL: $url"
    end

    if not set -l hex_url (binary_plist_url $metadata_file)
        echo >&2 "failed to process: $metadata_file"
        exit 1
    else if set -q _flag_verbose
        echo >&2 "converted URL to binary plist"
    end

    set -l attr com.apple.metadata:kMDItemWhereFroms

    if not xattr -wx $attr $hex_url $video_file
        echo >&2 "xattr failed to set $attr to `$hex_url`"
        exit 1
    else if set -q _flag_verbose
        echo >&2 "xattr set $attr to binary URL plist"
    end
end

# Creates a string from the current UNIX epoch, the name of the application,
# and a new UUID, and applies it to $file to set its quarantine attribute.
function set_quarantine_timestamp -a file
    set -l timestamp "0081;"(printf "%x" (date +%s))";yt-dlp;"(uuidgen)

    set -l attr com.apple.quarantine
    if not xattr -w $attr $timestamp $file
        echo >&2 "xattr failed to set $attr to `$timestamp`"
        exit 1
    else if set -q _flag_verbose
        echo >&2 "xattr set $attr = $timestamp"
    end
end

# ----------------------------------------------------------------------------
# main()
# ----------------------------------------------------------------------------

function main
    argparse k/keep v/verbose -- $argv
    or return

    set -q _flag_verbose[1]; and set -gx _flag_verbose $_flag_verbose

    set_quarantine_timestamp $argv[1]
    set_wherefrom $argv[1]

    if not set -q _flag_keep
        $XDG_BIN_HOME/trash $metadata_file
    end
end

main $argv
