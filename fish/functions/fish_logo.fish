function fish_logo --description 'Display the fish logo'
    __fish_logo_v4
    set_color normal
end

function __fish_logo_v3
    set -l red (set_color f00)
    set -l ora (set_color f80)
    set -l yel (set_color ff0)

    echo '                 '$red'___
  ___======____='$ora'-'$yel'-'$ora'-='$red')
/T            \_'$yel'--='$ora'=='$red')
[ \ '$ora'('$yel'0'$ora')   '$red'\~    \_'$yel'-='$ora'='$red')
 \      / )J'$ora'~~    \\'$yel'-='$red')
  \\\\___/  )JJ'$ora'~'$yel'~~   '$red'\)
   \_____/JJJ'$ora'~~'$yel'~~    '$red'\\
   '$ora'/ '$yel'\  '$yel', \\'$red'J'$ora'~~~'$yel'~~     '$ora'\\
  (-'$yel'\)'$red'\='$ora'|'$yel'\\\\\\'$ora'~~'$yel'~~       '$ora'L_'$yel'_
  '$ora'('$red'\\'$ora'\\)  ('$yel'\\'$ora'\\\)'$red'_           '$yel'\=='$ora'__
   '$red'\V    '$ora'\\\\'$red'\) =='$ora'=_____   '$yel'\\\\\\\\'$ora'\\\\
          '$red'\V)     \_) '$ora'\\\\'$yel'\\\\JJ\\'$ora'J\)
                      '$red'/'$ora'J'$yel'\\'$ora'J'$red'T\\'$ora'JJJ'$red'J)
                      (J'$ora'JJ'$red'| \UUU)
                       (UU)
'
end

function __fish_logo_v4
    # set -l palette "#810793" "#9d0287" "#dd4f8f" "#fff0a8"
    # set -l palette "#0055aa" "#0088ff" "#33ddbb" "#55dd33"
    # set -l palette "#0088bb" "#5588dd" "#aa88ff" "#dd99ff"
    set -l palette "#ff33aa" "#ff2288" "#ff8800" "#ffaa00"

    set -l shadow (set_color $palette[1])
    set -l lolite (set_color $palette[2])
    set -l hilite (set_color $palette[3])
    set -l accent (set_color $palette[4])

    echo '
                                 '$lolite'__~'$hilite'’
                               '$lolite'_/,'$hilite'~\
                             '$lolite'_-'$hilite' _~}
        '$lolite',/'$hilite'/}-__             '$lolite'/'$hilite'  __~}
       '$lolite'//'$hilite'‘,/ /,}-_         '$lolite'/ '$hilite' __~/
   '$lolite'__-/ ('$hilite'-,/'$lolite'_'$hilite',/ /,}      '$hilite'_'$lolite'/  '$hilite'_~‘}
  '$lolite'/           '$lolite'‘—'$hilite'/'$lolite'_'$hilite'/}'$lolite'__-_/   '$lolite'..'$hilite'=<
'$accent'O'$lolite')    ('$accent'O'$lolite')                    '$hilite'~_}
'$lolite'|   o       )   '$hilite'.....'$lolite'_===--==_ '$hilite'~_\
'$lolite'\        '$hilite'..'$lolite') '$hilite'....'$lolite'=='$shadow'=/        '$lolite'\-_~>
  '$lolite'\-_ '$hilite'....'$lolite'//'$hilite'....'$lolite'=='$shadow'='$hilite'\\'$shadow'’
     '$lolite'|\\'$shadow'====`'$lolite'|\_'$shadow'=‘’’'$hilite'\}
     '$lolite'| '$hilite'}    '$lolite'\ '$hilite'~}
             '$lolite'\\'$hilite'_}
'
end
