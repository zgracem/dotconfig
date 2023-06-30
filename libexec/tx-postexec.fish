#!/usr/local/bin/fish

# This script is called by Transmission.app when a torrent finishes downloading,
# and writes a JSON log file to ~/var/log/transmission about it.
# See: <https://github.com/transmission/transmission/blob/main/docs/Scripts.md>
#
# To "install":
#   defaults write -app Transmission DoneScriptPath "$XDG_CONFIG_HOME/libexec/tx-postexec.fish"

command -sq transmission-remote
or exit 127

set -q TR_TORRENT_HASH[1]
or exit

set -gx LOG_DIR "$HOME/var/log/transmission"
set -gx LOG_FILE $LOG_DIR/$TR_TORRENT_HASH.json
mkdir -p $LOG_DIR

function list-files -a id #=> $FILE_LIST
    transmission-remote --torrent "$id" --info-files | tail -n+3
end
set -gx FILE_LIST (list-files "$TR_TORRENT_ID")

function parse-files #=> $FILES_JSON
    set -l rxparts
    set -a rxparts "\s+(?<file_id>\d+):"
    set -a rxparts "\s+(?<done>[\d.%]+)"
    set -a rxparts "\s+(?<priority>\S+)"
    set -a rxparts "\s+(?<get>\S+)"
    set -a rxparts "\s+(?<file_size>[0-9.]+ \SB)"
    set -a rxparts "\s+(?<file_name>.+)\$"
    set -l regex (string join "" $rxparts)

    for line in $argv
        if string match -rq $regex -- $line
            set -f json
            set -a json (printf '"file_id":%i'      $file_id)
            set -a json (printf '"done":"%s"'       $done)
            set -a json (printf '"priority":"%s"'   $priority)
            set -a json (printf '"get":"%s"'        $get)
            set -a json (printf '"file_size":"%s"'  $file_size)
            set -a json (printf '"file_name":"%s"'  $file_name)
            echo -s '{' (string join , $json) '}' | jq -cR . | jq -cr .
        else
            continue
        end
    end
end
set -gx FILES_JSON (parse-files $FILE_LIST)

function print-details -a id #=> $DETAILS
    transmission-remote --torrent "$id" --info
end
set -gx DETAILS (print-details "$TR_TORRENT_ID")

function parse-details #=> $DETAILS_JSON
    set -l details (print-details $TR_TORRENT_ID | string trim)

    string match -rq '\AMagnet: (?<mg>.+)' $DETAILS
    string match -rq '\ADownloaded: (?<dl>[0-9.]+ \SB)\b' $DETAILS; or set dl None
    string match -rq '\AUploaded: (?<ul>[0-9.]+ \SB)\b' $DETAILS; or set ul None
    string match -rq '\ATotal size: (?<sz>[0-9.]+ \SB)\b' $DETAILS
    string match -rq '\ADate added:\s+(?<da>.+)' $DETAILS
    string match -rq '\ADate started:\s+(?<ds>.+)' $DETAILS
    # set -l dt (get-detail '(?<=\A\s{2}Downloading Time: \d)[^(]+\((\d+) seconds\)')[2]
    string match -rq '\ADownloading Time:\s+.+?(?<dt>\d+) seconds' $DETAILS

    set -l json
    set -a json (printf '"magnet":"%s"'         $mg)
    set -a json (printf '"downloaded":"%s"'     $dl)
    set -a json (printf '"uploaded":"%s"'       $ul)
    set -a json (printf '"total_size":"%s"'     $sz)
    set -a json (printf '"date_added":"%s"'     $da)
    set -a json (printf '"date_started":"%s"'   $ds)
    set -a json (printf '"download_time":%i'    $dt)

    echo -ns '{' (string join , $json) '}'
end
set -gx DETAILS_JSON (parse-details)

function basic-json-info
    set -l json
    set -l TR_TIME_LOCALTIME (string trim $TR_TIME_LOCALTIME)
    set -a json (printf '"time":"%s"'       $TR_TIME_LOCALTIME)
    set -a json (printf '"hash":"%s"'       $TR_TORRENT_HASH)
    set -a json (printf '"name":"%s"'       $TR_TORRENT_NAME)
    set -a json (printf '"directory":"%s"'  $TR_TORRENT_DIR)
    set -a json (printf '"id":%i'           $TR_TORRENT_ID)
    set -a json '"client":{"name":"Transmission"'
    set -a json (printf '"version":"%s"}'   $TR_APP_VERSION)

    set -l trackers (string split -n ,      $TR_TORRENT_TRACKERS)
    set -a json (printf '"trackers":[%s]' (string join , '"'$trackers'"'))

    echo -ns '{' (string join , $json) '}'
end

function add-details-and-files # stdout | add-details-and-files | stdin
    jq \
        --slurpfile details (printf "%s\n" $DETAILS_JSON | psub) \
        --slurpfile files (printf "%s\n" $FILES_JSON | psub) \
        '. + $DETAILS[0] + {files: $files}'
end

function process-json
    set -l jq_file (status dirname)/(basename (status filename) .fish).jq
    jq -M --from-file $jq_file
end

function print-complete-json-info
    basic-json-info | add-details-and-files | process-json
end

function main
    print-complete-json-info | tee $LOG_FILE
end

main
