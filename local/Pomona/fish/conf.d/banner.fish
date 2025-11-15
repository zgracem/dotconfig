status is-interactive; or return

set c0 (set_color normal)
set g1 (set_color green)
set g2 (set_color brgreen)
set p1 (set_color magenta)
set p2 (set_color brmagenta)
set p3 (echo -n $p2; set_color --bold --italics)
set ln (__term_href "http://Pomona.local/cgi-bin/status.cgi" Pomona)

echo -ns ' ' $g1 '\\\\' $g2 '\ /' $g1 '//' \r \n
echo -ns $p1 'o88' $p2 'OOO' $p1 '88o' \r \n
echo -ns ' 8' $p2 'OOOOO' $p1 '8   ' $g1 'Welcome to' $c0 \r \n
echo -ns $p1 ' °O' $p2 'OOO' $p1 'O°     ' $p3 $ln $c0 \r \n
echo -ns $p1 '  8O' $p2 'O' $p1 'O8  ' \r \n
echo -ns '   °°°' $c0 \r \n
