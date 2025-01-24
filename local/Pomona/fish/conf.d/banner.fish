status is-interactive; or return

echo
figlet -f cosmic $hostname | lolcat -S 333
echo

set -U last_motd (date +%F)
