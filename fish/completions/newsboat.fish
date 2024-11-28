set -l newsboat_execute_commands '
    reload\treload\ all\ feeds\ and\ quit
    print-unread\tprint\ number\ of\ unread\ feeds\ and\ quit
'

set -l newsboat_log_levels '
    1\tuser\ error
    2\tcritical
    3\terror
    4\twarning
    5\tinfo
    6\tdebug
'

complete -c newsboat -f
complete -c newsboat -s e -l export-to-opml -d "export OPML feed to stdout"
complete -c newsboat -l export-to-opml2 -d "export OPML 2.0 feed including tags to stdout"
complete -c newsboat -s r -l refresh-on-start -d "refresh feeds on start"
complete -c newsboat -s i -l import-from-opml -rF -d "import OPML file"
complete -c newsboat -s u -l url-file -rF -d "read RSS feed URLs from file"
complete -c newsboat -s c -l cache-file -rF -d "path to cache file"
complete -c newsboat -s C -l config-file -rF -d "path to configuration file"
complete -c newsboat -l queue-file -rF -d "path to podcast queue"
complete -c newsboat -l search-history-file -rF -d "save search history"
complete -c newsboat -l cmdline-history-file -rF -d "save command line history"
complete -c newsboat -s X -l vacuum -d "compact the cache"
complete -c newsboat -s x -l execute -x -a $newsboat_execute_commands -d "execute commands"
complete -c newsboat -s q -l quiet -d "quiet startup"
complete -c newsboat -s v -l version -d "get version information"
complete -c newsboat -s l -l log-level -x -a $newsboat_log_levels -d "set log level"
complete -c newsboat -s d -l log-file -rF -d "path to output log"
complete -c newsboat -s E -l export-to-file -rF -d "export list of read articles"
complete -c newsboat -s I -l import-from-file -rF -d "import list of read articles"
complete -c newsboat -s h -l help -d "print help"
complete -c newsboat -l cleanup -d "remove unreferenced items from cache"
