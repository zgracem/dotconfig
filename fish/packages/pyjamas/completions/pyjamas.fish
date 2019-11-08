set -l formats json plist toml yaml

complete -c pyjamas -s i -l in -xa "$formats" -d "Input format"
complete -c pyjamas -s o -l out -xa "$formats" -d "Output format"
