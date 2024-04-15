set -l hexyl_block_sizes '
    512\tdefault
    1024\t
    4096\t
'

set -l hexyl_colors '
    always\tdefault
    auto\t
    never\t
    force\t
'

set -l hexyl_character_tables '
    default\tuse\ Unicode\ chars\ for\ non-ASCII
    ascii\tuse\ only\ ASCII\ chars
    codepage-437\tuse\ cp437\ for\ non-ASCII
'

set -l hexyl_panels '
    2\tdefault
    1\t
    auto\tbased\ on\ terminal\ width
'

set -l hexyl_group_sizes '
    1\tdefault
    2\t
    4\t
    8\t
'

set -l hexyl_endianness '
    big\tdefault
    little\t
'

set -l hexyl_bases '
    hexadecimal\tdefault
    decimal\t
    octal\t
    binary\t
'

complete -c hexyl -s n -l length -s c -l bytes -s l -x -d 'Read only N bytes'
complete -c hexyl -s s -l skip -d 'Skip first N bytes of input'
complete -c hexyl -l block-size -xa "$hexyl_block_sizes" -d 'Set block size to N bytes'
complete -c hexyl -s v -l no-squeezing -d 'Display all input data'
complete -c hexyl -l color -xa "$hexyl_colors" -d 'When to use color'
complete -c hexyl -l border -xa 'unicode ascii none' -d 'How to draw border'
complete -c hexyl -s p -l plain -d 'No color or decorations'
complete -c hexyl -l no-characters -d "Don't show character panel"
complete -c hexyl -s C -l characters -d 'Show character panel'
complete -c hexyl -l character-table -xa "$hexyl_character_tables" -d 'Define char-byte mapping'
complete -c hexyl -s P -l no-position -d "Don't display position panel"
complete -c hexyl -s o -l display-offset -x -d 'Add N bytes to display position'
complete -c hexyl -l panels -xa "$hexyl_panels" -d 'Number of data panels'
complete -c hexyl -s g -l group-size -xa "$hexyl_group_sizes" -d "Group N bytes together"
complete -c hexyl -l endianness -n '__fish_seen_argument -s g -l groupsize -l group-size' -xa "$hexyl_endianness" -d 'Print in format'
complete -c hexyl -s e -n 'not __fish_seen_argument -l endianness' -d 'Print in little-endian format'
complete -c hexyl -s b -l base -xa "$hexyl_bases" -d 'Set base used for bytes'
complete -c hexyl -l terminal-width -n 'not __fish_seen_argument -l panels' -d 'Display N terminal columns'
complete -c hexyl -s h -l help -d 'Print help'
complete -c hexyl -s V -l version -d 'Print version'
