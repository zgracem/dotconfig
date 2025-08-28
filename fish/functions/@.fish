function @ --description 'Format UNIX epoch as human-readable date'
    argparse -xs,m,l 's/short' 'm/medium' 'l/long' -- $argv
    or return

    set -l epoch $argv[1]

    if not set -q epoch[1]
        gdate +%s
        return
    else if set -q _flag_long
        set -f format +"%A, %B %-e, %Y @ %H:%M:%S %z"
    else if set -q _flag_medium
        set -f format --rfc-2822 # +"%a, %d %b %Y %T %z"
    else # if set -q _flag_short
        set -f format --iso-8601=seconds # +"%Y-%m-%dT%H:%M:%S%z"
    end

    gdate --date="@$epoch" $format
end
