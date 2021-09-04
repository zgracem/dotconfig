# MultiMarkdown <https://fletcher.github.io/MultiMarkdown-6/>

set -l __mmd_help (multimarkdown --help | string collect)
set -l formats (echo "$__mmd_help" | string replace -fr '.+FORMAT = ((?:\w+\|?)+)' '$1' | tr '|' ' ')
set -l langs (echo "$__mmd_help" | string replace -fr '.+LANG = ((?:\w+\|?)+)' '$1' | tr '|' ' ')

complete -c multimarkdown -l help -d 'Display this help and exit'
complete -c multimarkdown -l version -d 'Display version info and exit'
complete -c multimarkdown -s b -l batch -d 'Process each file separately'
complete -c multimarkdown -s f -l full -d 'Force a complete document'
complete -c multimarkdown -s s -l snippet -d 'Force a snippet'
complete -c multimarkdown -s c -l compatibility -d 'Markdown compatibility mode'
complete -c multimarkdown -l random -d 'Use random numbers for footnote anchors'
complete -c multimarkdown -l nosmart -d 'Disable smart typography'
complete -c multimarkdown -l nolabels -d 'Disable id attributes for headers'
complete -c multimarkdown -l notransclude -d 'Disable file transclusion'
complete -c multimarkdown -l opml -d 'Convert OPML source to plain text before processing'
complete -c multimarkdown -s t -l to -xa "$formats" -d 'Convert to FORMAT'
complete -c multimarkdown -s o -l output -r -d 'Send output to FILE'
complete -c multimarkdown -s a -l accept -d 'Accept all CriticMarkup changes'
complete -c multimarkdown -s r -l reject -d 'Reject all CriticMarkup changes'
complete -c multimarkdown -s l -l lang -xa "$langs" -d 'Language/smart quote localization'
complete -c multimarkdown -s m -l metadata-keys -d 'List all metadata keys'
complete -c multimarkdown -s e -l extract -x -d 'Extract specified metadata key'
