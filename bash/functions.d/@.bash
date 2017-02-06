# converts a Unix timestamp to a regularly-formatted date and time
function @ { date -d "@$1" +"%a %e %b %Y %T"; }
