function abex -d "Print the expansion of a fish abbreviation"
    set -l abbr (string escape --style=regex $argv[1])
    abbr --show | string match -rg -- "-- $abbr '?(.+?)'?\$"
end
