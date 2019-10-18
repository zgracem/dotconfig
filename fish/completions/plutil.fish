complete -c plutil --erase
complete -c plutil -o help -d "Show usage information and exit"
complete -c plutil -o lint -d "Check plist files for syntax errors"
complete -c plutil -o convert -xa "xml1 binary1 json swift objc" -d "Rewrite file in FORMAT"
complete -c plutil -s r -n "__fish_seen_argument -s convert; and __fish_seen_subcommand_from json" -d "Pretty-print JSON"
complete -c plutil -s o -r -n "__fish_seen_argument -s convert" -d "Alternate path for conversion result"
complete -c plutil -s e -r -n "__fish_seen_argument -s convert" -d "Alternate extension for converted files"
complete -c plutil -s p -d "Print the plist in a human-readable fashion"
complete -c plutil -s s -d "Be silent on success"
