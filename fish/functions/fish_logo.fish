function fish_logo --description 'Display the fish logo'
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
