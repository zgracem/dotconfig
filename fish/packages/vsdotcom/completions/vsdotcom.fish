complete -c vsdotcom -f # do not operate on files

complete -c vsdotcom -l build -n __fish_is_first_arg
complete -c vsdotcom -n "__fish_seen_argument -l build; and __fish_is_nth_arg 2" -l local
complete -c vsdotcom -n "__fish_seen_argument -l build; and not __fish_seen_argument -l local" -l docs
complete -c vsdotcom -n "__fish_seen_argument -l build; and not __fish_seen_argument -l local" -l json
complete -c vsdotcom -n "__fish_seen_argument -l build; and not __fish_seen_argument -l local" -l remote

complete -c vsdotcom -l deploy -n __fish_is_first_arg
complete -c vsdotcom -n "__fish_seen_argument -l deploy" -l local
complete -c vsdotcom -n "__fish_seen_argument -l deploy" -l site
complete -c vsdotcom -n "__fish_seen_argument -l deploy" -l docs
complete -c vsdotcom -n "__fish_seen_argument -l deploy" -l json

complete -c vsdotcom -l thumbs -n __fish_is_first_arg
complete -c vsdotcom -n "__fish_seen_argument -l thumbs" -l press
complete -c vsdotcom -n "__fish_seen_argument -l thumbs" -l photos

complete -c vsdotcom -l test  -n __fish_is_first_arg
complete -c vsdotcom -l presszip -n __fish_is_first_arg
complete -c vsdotcom -l help -n __fish_is_first_arg
