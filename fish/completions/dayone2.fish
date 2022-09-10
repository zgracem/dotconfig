# dayone2

function __fish_complete_dayone2_attachments
    # photo/image, video, audio, and pdf
    set -l files *.{jpg,png,gif,m4a,mp4,m4v,wav,m4a,mp3,pdf}
end

complete -c dayone2 --no-files
complete -c dayone2 -s a -l attachments -xa "(__fish_complete_dayone2_attachments)" -d "Path(s) to attachment(s)"
complete -c dayone2 -s t -l tags -x -d "Entry tags, space separated"
complete -c dayone2 -s j -l journal -d "Name of journal"
complete -c dayone2 -s d -l date -d "Date"
complete -c dayone2 -s z -l time-zone -xa "(__fish_complete_timezones)" -d "Time zone"
complete -c dayone2 -l isoDate -d "Format: yyyy-mm-ddThh:mm:ssZ"
complete -c dayone2 -s s -l starred -d "Star the entry"
complete -c dayone2 -l coordinate -x -d "Latitude and longitude"
complete -c dayone2 -l no-stdin -d "Ignore standard input"
complete -c dayone2 -l verbose -d "Log verbosely to stderr"
complete -c dayone2 -s h -l help -d "Display help and exit"
complete -c dayone2 -s v -l version -d "Display version and exit"
