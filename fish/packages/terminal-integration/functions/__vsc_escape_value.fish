# Escapes backslashes, newlines, and semicolons.
function __vsc_escape_value -d "Serialize the command line"
    set --local commandline "$argv"
    # `string replace` automatically breaks its input apart on any newlines.
    # Then `string join` at the end will bring it all back together.
    string replace --all -- "\\" "\\\\" $commandline \
        | string replace --all ";" "\x3b" \
        | string join "\x0a"
end
