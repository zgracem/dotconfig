# See ~/.config/env.d/term.env
function term_alert
    echo -ens $OSC "9;" "$argv" $ST
end
