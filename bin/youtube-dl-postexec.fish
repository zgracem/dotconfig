#!/usr/bin/env fish

# $XDG_CONFIG_HOME/youtube-dl/config needs:
#   --write-info-json
# and
#   --exec /path/to/youtube-dl-postexec.fish {}

set --global video_file "$argv[1]"

set --local file_parts (string split -rm1 . "$video_file")
set --local base_dir (dirname $file_parts[1])
set --global video_basename (basename $file_parts[1])

# `youtube-dl --write-info-json` saves metadata to the same path as the
# download, but with the extension ".info.json".
set --global metadata_file (string join / $base_dir $video_basename).info.json

function bail -a message code
    test -n "$code"; or set -l code 1

    echo >&2 $message
    exit $code
end

function _url_to_hex -a url
    set --global temp_dir (mktemp -d -t $video_basename"_XXXXXX")
    set --local urls "$temp_dir/$video_basename"

    jq -r '.webpage_url' $metadata_file >$urls.txt
    or bail "failed to parse: $metadata_file"

    jq -Rsc '.' $urls.txt >$urls.json
    or bail "failed to parse: $urls.txt"

    plutil -convert binary1 -o $urls.plist $urls.json
    or bail "failed to convert to plist: $urls.json"

    set --local hex (xxd -p -u $urls.plist)
    or bail "failed to process to hex: $urls.plist"

    string join "" $hex

    # set --global temp_files $metadata_file $urls.txt $urls.json $urls.plist
end

function set_where_from
    set --local attr com.apple.metadata:kMDItemWhereFroms
    set --local metadata (_url_to_hex)

    xattr -wx $attr "$metadata" $video_file
    or bail "xattr failed to set $attr to `$metadata`"
end

function set_quarantine
    set --local attr com.apple.quarantine
    set --local metadata (printf "0081;%x;youtube-dl;%s" (date +%s) (uuidgen))

    xattr -w $attr "$metadata" $video_file
    or bail "xattr failed to set $attr to `$metadata`"
end

set_quarantine
set_where_from

# set -q temp_files; and rm -f $temp_files
