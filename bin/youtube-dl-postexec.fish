#!/usr/bin/env fish

# youtube-dl's config needs:
#   --write-info-json
# and
#   --exec /path/to/youtube-dl-postexec.fish {}

set --global video_file "$argv[1]"

set file_parts (string split -rm1 . "$video_file")
set base_dir (dirname $file_parts[1])
set --global base_name (basename $file_parts[1])

# `youtube-dl --write-info-json` saves the JSON with the same filename as the
# download, but with the extension ".info.json".
set --global json_file (string join / $base_dir $base_name).info.json

function _url_to_hex -a url
  set --global temp_dir   (mktemp -d -t $base_name"_XXXXXX")
  set --local  urls_txt   "$temp_dir/$base_name.txt"
  set --local  urls_json  "$temp_dir/$base_name.json"
  set --local  urls_plist "$temp_dir/$base_name.plist"

  if not jq -r '.webpage_url' $json_file > $urls_txt
    echo "failed to parse file: $json_file" >&2
    return 1
  end

  if not jq -Rsc '.' $urls_txt > $urls_json
    echo "failed to parse file: $urls_txt" >&2
    return 1
  end

  plutil -convert binary1 -o $urls_plist $urls_json
  or return

  set --local hex (xxd -p -u $urls_plist)
  or return

  string join "" $hex

  set --global temp_files $json_file $urls_txt $urls_json $urls_plist
end

function set_where_from
  set --local hex (_url_to_hex)
  or exit

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

# set -q temp_files; and rm -f $temp_files
