# completion for defaults (macOS)

complete --no-files -c defaults

function __fish_defaults_domains
    defaults domains | string split ", "
end

complete -c defaults -o currentHost -d 'Only operate on this host'
complete -c defaults -o host -xf -d 'Only operate on HOST'

# subcommands which take a domain as their first argument
set -l defaults_domain_cmds read read-type write rename delete import export

# read
complete -c defaults -n __fish_use_subcommand -a read -d 'Print defaults'
complete -c defaults -n "__fish_seen_subcommand_from $defaults_domain_cmds" -x -a '(__fish_defaults_domains)'
complete -c defaults -n "__fish_seen_subcommand_from $defaults_domain_cmds" -o app -x
complete -c defaults -n "__fish_seen_subcommand_from $defaults_domain_cmds" -s g -o globalDomain

# write
complete -c defaults -n __fish_use_subcommand -a write -d 'Writes domain or a key in the domain'
complete -c defaults -n '__fish_seen_subcommand_from write' -o string -d 'String'
complete -c defaults -n '__fish_seen_subcommand_from write' -o data -d 'Raw data bytes'
complete -c defaults -n '__fish_seen_subcommand_from write' -o int -d 'Integer'
complete -c defaults -n '__fish_seen_subcommand_from write' -o float -d 'Floating point number'
complete -c defaults -n '__fish_seen_subcommand_from write' -o bool -d 'Boolean'
complete -c defaults -n '__fish_seen_subcommand_from write' -o date -d 'Date'
complete -c defaults -n '__fish_seen_subcommand_from write' -o array -d 'Array'
complete -c defaults -n '__fish_seen_subcommand_from write' -o array-add -d 'Append new elements'
complete -c defaults -n '__fish_seen_subcommand_from write' -o dict -d 'Dictionary'
complete -c defaults -n '__fish_seen_subcommand_from write' -o dict-add -d 'Add new key/value pairs'

complete -c defaults -n __fish_use_subcommand -a read-type -d 'Print the type of a key in a domain'
complete -c defaults -n __fish_use_subcommand -a rename -d 'Rename old_key to new_key in a domain'
complete -c defaults -n __fish_use_subcommand -a delete -d 'Delete a domain or a key in a domain'
complete -c defaults -n __fish_use_subcommand -a import -d 'Import to a domain'
complete -c defaults -n __fish_use_subcommand -a export -d 'Export a domain'
complete -c defaults -n __fish_use_subcommand -a domains -d 'Print all domains'
complete -c defaults -n __fish_use_subcommand -a find -d 'Searches for word in domain names, keys, and values'
complete -c defaults -n __fish_use_subcommand -a help -d 'Prints a list of possible command formats'
