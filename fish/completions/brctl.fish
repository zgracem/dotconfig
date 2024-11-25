# brctl - manages the CloudDocs daemon

complete -c brctl -f
complete -c brctl -n __fish_use_subcommand -a diagnose -d "diagnose and collect logs"
complete -c brctl -n __fish_use_subcommand -a download -d "download a local copy"
complete -c brctl -n __fish_use_subcommand -a evict -d "evict a local copy"
complete -c brctl -n __fish_use_subcommand -a log -d "manage logging"
complete -c brctl -n __fish_use_subcommand -a dump -d "dump the CloudDocs database"
complete -c brctl -n __fish_use_subcommand -a monitor -d "monitor container w/ NSMetadataQuery"
complete -c brctl -n __fish_use_subcommand -a versions -d "list non-local versions of document"
complete -c brctl -n __fish_use_subcommand -a status -d "print partly synced/applied items"
complete -c brctl -n __fish_use_subcommand -a accounts -d "display eligible accounts and their status"
complete -c brctl -n __fish_use_subcommand -a quota -d "display available quota"

complete -c brctl -n "__fish_seen_subcommand_from accounts" -s w -l wait -d "wait for accounts to load"

complete -c brctl -n "__fish_seen_subcommand_from diagnose" -F
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s M -l collect-mobile-documents -r -d "specify container"
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s s -l sysdiagnose -d "don't collect sysdiagnose data"
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s t -l uitest -d "collect logs for UI tests"
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s n -l name -x -d "change device's name"
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s f -l full -d "full diagnosis"
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s d -l doc -rF -d "collect info about a document"
complete -c brctl -n "__fish_seen_subcommand_from diagnose" -s e -l no-reveal -d "don't reveal in Finder when done"

complete -c brctl -n "__fish_seen_subcommand_from download" -rF

complete -c brctl -n "__fish_seen_subcommand_from evict" -rF

complete -c brctl -n "__fish_seen_subcommand_from log" -s a -l all -d "show all system logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s p -l predicate -d "additional predicate"
complete -c brctl -n "__fish_seen_subcommand_from log" -s x -l process -x -d "filter events from process"
complete -c brctl -n "__fish_seen_subcommand_from log" -s S -l start -x -d "start date for log dump"
complete -c brctl -n "__fish_seen_subcommand_from log" -s E -l end -x -d "end date for log dump"
complete -c brctl -n "__fish_seen_subcommand_from log" -s b -d "show CloudDocs logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s f -d "show FileProvider related logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s F -d "show FruitBasket related logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s N -d "show network related logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s g -d "show Genstore related logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s i -d "show SQL and CloudDocs logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s o -d "show local storage logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s D -d "show logs from the Denator subsystem"
complete -c brctl -n "__fish_seen_subcommand_from log" -s z -l local-timezone -d "convert timestamps to local"
complete -c brctl -n "__fish_seen_subcommand_from log" -l dark-mode -d "adapt color scheme to dark mode"
complete -c brctl -n "__fish_seen_subcommand_from log" -s q -l quick -d "skip pre-processing"
complete -c brctl -n "__fish_seen_subcommand_from log" -s c -l color -x -a "yes no"
complete -c brctl -n "__fish_seen_subcommand_from log" -s d -l path -rF -d "specify logs dir"
complete -c brctl -n "__fish_seen_subcommand_from log" -s H -l home -rF -d "specify home dir"
complete -c brctl -n "__fish_seen_subcommand_from log" -s f -l filter -x -d "only show matching lines"
complete -c brctl -n "__fish_seen_subcommand_from log" -s m -l multiline -x -a "yes no" -d "multiple line logging"
complete -c brctl -n "__fish_seen_subcommand_from log" -s n -l number -x -d "initial number of lines"
complete -c brctl -n "__fish_seen_subcommand_from log" -s p -l page -d "use paging"
complete -c brctl -n "__fish_seen_subcommand_from log" -s w -l wait -d "wait for new logs"
complete -c brctl -n "__fish_seen_subcommand_from log" -s t -l shorten -d "shorten UUIDs, paths, etc."
complete -c brctl -n "__fish_seen_subcommand_from log" -s s -l digest -d "only print digest logs"

complete -c brctl -n "__fish_seen_subcommand_from dump" -s o -l output -rF -d "redirect output to path"
complete -c brctl -n "__fish_seen_subcommand_from dump" -s d -l database-path -rF -d "use database at path"
complete -c brctl -n "__fish_seen_subcommand_from dump" -s e -l enterprise -d "use the Data Separated database"
complete -c brctl -n "__fish_seen_subcommand_from dump" -s i -l itemless -d "don't dump items"
complete -c brctl -n "__fish_seen_subcommand_from dump" -s u -l upgrade -d "upgrade db first if necessary"
complete -c brctl -n "__fish_seen_subcommand_from dump" -s v -l verbose -d "be verbose"

complete -c brctl -n "__fish_seen_subcommand_from monitor" -s S -l scope -x -a "DOCS DATA BOTH" -d "restrict scope"
complete -c brctl -n "__fish_seen_subcommand_from monitor" -s g -d "dump global activity"
complete -c brctl -n "__fish_seen_subcommand_from monitor" -s i -d "dump changes incrementally"
complete -c brctl -n "__fish_seen_subcommand_from monitor" -s t -x -d "amount of time in seconds to run the query,"
complete -c brctl -n "__fish_seen_subcommand_from monitor" -s p -d "only static gathering"
complete -c brctl -n "__fish_seen_subcommand_from monitor" -s w -l wait-uploaded -d "wait for all items to upload"

complete -c brctl -n "__fish_seen_subcommand_from versions" -s a -l all -d "list all non-local versions"
