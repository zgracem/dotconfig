function @ --description 'Format UNIX epoch as human-readable date'
    argparse -xs,m,l 's/short' 'm/medium' 'l/long' -- $argv
    or return

    set -l epoch $argv[1]
    set -l format

    if set -q _flag_long
        set format +"%A, %B %-e, %Y @ %H:%M:%S %z"
    else if set -q _flag_medium
        set format --rfc-2822 # +"%a, %d %b %Y %T %z"
    else # if set -q _flag_short
        set format --iso-8601=seconds # +"%Y-%m-%dT%H:%M:%S%z"
    end

    gdate --date="@$epoch" $format
end
