#!/usr/bin/env fish

# youtube-dl's config needs:
#   --write-info-json
# and
#   --exec /path/to/youtube-dl-post.fish {}

set video_file "$argv[1]"

set file_parts (string split -rm1 . "$video_file")
set base_dir (dirname $file_parts[1])
set base_name (basename $file_parts[1])

# `youtube-dl --write-info-json` saves the JSON with the same filename as the
# download, but with the extension ".info.json".
set json_file (string join / $base_dir $base_name).info.json

function _url_to_hex -a url
  jq -r '.webpage_url' $json_file | jq -sc '.' \
  | plutil -convert binary1 -o - - \
  | xxd -p -u \
  | string join ""
end

function set_where_from
  set --local hex (_url_to_hex); or exit
  xattr -wx com.apple.metadata:kMDItemWhereFroms "$hex" $video_file
  or exit
end

function set_quarantine
  set --local md (printf "0081;%x;youtube-dl;%s" (date +%s) (uuidgen))
  xattr -w com.apple.quarantine "$md" $video_file
  or exit
end

set_where_from
set_quarantine

rm -f $json_file
