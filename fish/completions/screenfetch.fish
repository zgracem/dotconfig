# screenfetch <https://github.com/KittyKatt/screenFetch>

function __fish_complete_screenfetch_distros
  set -l distros ALDOS "Alpine Linux" "Amazon Linux" Antergos "Arch Linux" \
    ArcoLinux "Artix Linux" "blackPanther OS" BLAG BunsenLabs CentOS Chakra \
    Chapeau "Chrome OS" "Chromium OS" CrunchBang CRUX Debian Deepin DesaOS \
    Devuan "Dragonfly BSD" Dragora "elementary OS" EuroLinux "Evolve OS" \
    Exherbo Fedora FreeBSD Frugalware Fuduntu Funtoo Fux Gentoo gNewSense \
    "Guix System" Haiku "Hyperbola GNU/Linux-libre" januslinux "Jiyuu Linux" \
    "Kali Linux" KaOS "KDE neon" Kogaion Korora "Linux Mint" LinuxDeepin LMDE \
    Logos "Mac OS X" Mageia Mandrake Mandriva Manjaro Mer NetBSD Netrunner \
    NixOS OBRevenge OpenBSD openSUSE "Oracle Linux" "OS Elbrus" \
    "Parabola GNU/Linux-libre" Pardus "Parrot Security" PCLinuxOS PeppermintOS \
    "Proxmox VE" PureOS "Qubes OS" Raspbian "Red Hat Enterprise Linux" ROSA \
    Sabayon SailfishOS "Scientific Linux" Siduction Slackware Solus \
    "Source Mage GNU/Linux" SparkyLinux SteamOS Sulin "SUSE Linux Enterprise" \
    SwagArch TinyCore Trisquel Ubuntu Viperr Void "Windows+Cygwin" \
    "Windows+MSYS2" "Zorin OS"

  for d in $distros; printf '%s\\n' $d; end
end

complete -c screenfetch -s v -d 'Verbose output'
complete -c screenfetch -s o -x -d 'Set script variables on the command line'
complete -c screenfetch -s d -x -d 'Set what information is displayed on the command line'
complete -c screenfetch -s n -d 'Do not display ASCII distribution logo'
complete -c screenfetch -s L -d 'Display ASCII distribution logo only'
complete -c screenfetch -s N -d 'Strip all color from output'
complete -c screenfetch -s w -d 'Wrap long lines'
complete -c screenfetch -s t -d 'Truncate output based on terminal width'
complete -c screenfetch -s p -d 'Output in portrait mode, with logo above info'
complete -c screenfetch -s s -d 'Take a screenshot'
complete -c screenfetch -s u -x -a 'teknik imgur mediacrush hmp' -d 'Specify an image host'
complete -c screenfetch -s c -d 'Change the outputted colors'
complete -c screenfetch -s a -r -d 'Specify custom ASCII art'
complete -c screenfetch -s S -r -d 'Specify a custom screenshot command'
complete -c screenfetch -s D -x -a "(__fish_complete_screenfetch_distros)" -d 'Specify your distribution'
complete -c screenfetch -s A -x -a "(__fish_complete_screenfetch_distros)" -d 'Specify the distribution art'
complete -c screenfetch -s E -d 'Suppress output of errors'
complete -c screenfetch -s V -l version -d 'Display current script version'
complete -c screenfetch -s h -l help -d 'Display this help'
