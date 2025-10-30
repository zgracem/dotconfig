function fish_logo --description "Display the fish logo"
    argparse v#version -- $argv
    or return

    # set -f palette "#f00" "#f00" "#f80" "#ff0"
    # set -f palette "#809" "#908" "#d58" "#fec"
    # set -f palette "#05a" "#08f" "#3db" "#5d3"
    # set -f palette "#08b" "#58d" "#a8f" "#d9f"
    set -f palette "#f3a" "#f28" "#f80" "#fa0"

    set -fx C0 (set_color $palette[1])
    set -fx C1 (set_color $palette[2])
    set -fx C2 (set_color $palette[3])
    set -fx C3 (set_color $palette[4])

    switch $_flag_version
        case 3 2 1
            __fish_logo_v3
        case 4
            __fish_logo_v4
        case 5 6 7 8 9
            echo >&2 "invalid fish version: $_flag_version"
            return 1
        case '*' # default
            __fish_logo_v4
    end
    set_color normal
end

function __fish_logo_v3
    echo '                 '$C1'___
  ___======____='$C2'-'$C3'-'$C2'-='$C1')
/T            \_'$C3'--='$C2'=='$C1')
[ \ '$C2'('$C3'0'$C2')   '$C1'\~    \_'$C3'-='$C2'='$C1')
 \      / )J'$C2'~~    \\'$C3'-='$C1')
  \\\\___/  )JJ'$C2'~'$C3'~~   '$C1'\)
   \_____/JJJ'$C2'~~'$C3'~~    '$C1'\\
   '$C2'/ '$C3'\  '$C3', \\'$C1'J'$C2'~~~'$C3'~~     '$C2'\\
  (-'$C3'\)'$C1'\='$C2'|'$C3'\\\\\\'$C2'~~'$C3'~~       '$C2'L_'$C3'_
  '$C2'('$C1'\\'$C2'\\)  ('$C3'\\'$C2'\\\)'$C1'_           '$C3'\=='$C2'__
   '$C0'\V    '$C2'\\\\'$C0'\) =='$C2'=_____   '$C3'\\\\\\\\'$C2'\\\\
          '$C0'\V)     \_) '$C2'\\\\'$C3'\\\\JJ\\'$C2'J\)
                      '$C0'/'$C2'J'$C3'\\'$C2'J'$C0'T\\'$C2'JJJ'$C0'J)
                      (J'$C2'JJ'$C0'| \UUU)
                       (UU)
'
end

function __fish_logo_v4
    echo '
                                 '$C1'__~'$C2'’
                               '$C1'_/,'$C2'~\
                             '$C1'_-'$C2' _~}
        '$C1',/'$C2'/}-__             '$C1'/'$C2'  __~}
       '$C1'//'$C2'‘,/ /,}-_         '$C1'/ '$C2' __~/
   '$C1'__-/ ('$C2'-,/'$C1'_'$C2',/ /,}      '$C2'_'$C1'/  '$C2'_~‘}
  '$C1'/           '$C1'‘—'$C2'/'$C1'_'$C2'/}'$C1'__-_/   '$C1'..'$C2'=<
'$C3'O'$C1')    ('$C3'O'$C1')                    '$C2'~_}
'$C1'|   o       )   '$C2'.....'$C1'_===--==_ '$C2'~_\
'$C1'\        '$C2'..'$C1') '$C2'....'$C1'=='$C0'=/        '$C1'\-_~>
  '$C1'\-_ '$C2'....'$C1'//'$C2'....'$C1'=='$C0'='$C2'\\'$C0'’
     '$C1'|\\'$C0'====`'$C1'|\_'$C0'=‘’’'$C2'\}
     '$C1'| '$C2'}    '$C1'\ '$C2'~}
             '$C1'\\'$C2'_}
'
end
