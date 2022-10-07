#!/usr/local/bin/fish

# This script is called by Transmission.app when a torrent finished downloading,
# and writes a log file to ~/var/log about it.
#
# defaults write -app Transmission DoneScriptPath "$XDG_CONFIG_HOME/libexec/tx-postexec.fish"

fish_add_path --move $HOME/opt/bin
command -sq tremc; or exit 127

if not set -q TR_TORRENT_HASH[1]
    echo >&2 "TR_TORRENT_HASH not found in environment, aborting"
    exit
end

set -g log_dir "$HOME/var/log/transmission"
set -g log_file $log_dir/$TR_TORRENT_HASH.json
mkdir -p $log_dir

function list-files -a id #=> $file_list
    tremc -- --torrent "$id" --info-files | tail -n+3
end
set -gx file_list (list-files "$TR_TORRENT_ID")

function parse-files #=> $files_json
    set -l file_data

    for line in $argv
        set -l matches (string match -r '\s+(\d+):\s+([\d.%]+)\s+(\S+)\s+(\S+)\s+([0-9.]+ \SB)\s+(.+)$' $line)
        or continue

        set -l json
        set -a json '"file_id":%i'      $matches[2]
        set -a json '"file_name":"%s"'  $matches[3]
        set -a json '"file_size":"%s"'  $matches[4]
        set -a json '"get":"%s"'        $matches[5]
        set -a json '"priority":"%s"'   $matches[6]
        set -a json '"done":"%s"'       $matches[7]

        echo -s '{' (string join , $json) '}' | jq -cR . | jq -cr .
    end
end
set -gx files_json (parse-files $file_list)

function print-details -a id #=> $details
    tremc -- --torrent "$id" --info
end
set -gx details (print-details "$TR_TORRENT_ID")

function parse-details #=> $details_json
    function get-detail -a pattern
        string match -r $pattern $details
    end

    set -l mg (get-detail '(?<=\A\s{2}Magnet: )magnet:.+$')
    set -l dl (get-detail '(?<=\A\s{2}Downloaded: )[0-9.]+ \SB\b')
    or set dl None
    set -l ul (get-detail '(?<=\A\s{2}Uploaded: )[0-9.]+ \SB\b')
    or set ul None
    set -l sz (get-detail '(?<=\A\s{2}Total size: )[0-9.]+ \SB\b')
    set -l da (get-detail '(?<=\A\s{2}Date added: \s{6}).+$')
    set -l ds (get-detail '(?<=\A\s{2}Date started: \s{4}).+$')
    set -l dt (get-detail '(?<=\A\s{2}Downloading Time: \d)[^(]+\((\d+) seconds\)')[2]

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
set -gx details_json (parse-details)

function basic-json-info
    set -l json
    set -a json (printf '"time":"%s"'       $TR_TIME_LOCALTIME)
    set -a json (printf '"hash":"%s"'       $TR_TORRENT_HASH)
    set -a json (printf '"name":"%s"'       $TR_TORRENT_NAME)
    set -a json (printf '"directory":"%s"'  $TR_TORRENT_DIR)
    set -a json (printf '"id":%i'           $TR_TORRENT_ID)
    set -a json         '"client":{"name":"Transmission"}'
    set -a json (printf '"version":"%s"'    $TR_APP_VERSION)

    echo -ns '{' (string join , $json) '}'
end

function add-details-and-files
    jq \
        --slurpfile details (printf "%s\n" $details_json | psub) \
        --slurpfile files (printf "%s\n" $files_json | psub) \
        '. + $details[0] + {files: $files}'
end

function process-json
    set -l jq_file (status dirname)/(basename (status filename) .fish)
    jq -M --from-file $dir/$base.jq
end

function print-complete-json-info
    basic-json-info | add-details-and-files | process-json
end

function main
    print-complete-json-info >$log_file
end

main
