# vim:ft=ruby

tap "homebrew/command-not-found"
tap "zgracem/caveats"

brew "bash"
brew "ncurses"
brew "hexyl"
brew "htop"
brew "parallel"
brew "source-highlight" # for less

# tmux
brew "tmux"
brew "pam-reattach" if OS.mac?

# GNU utilities
if OS.mac?
  brew "binutils"
  brew "diffutils"
  brew "findutils"
  brew "inetutils"
  brew "gawk"
  brew "gnu-tar"
  brew "grep"
end

# documentation
brew "dos2unix"
brew "ghostscript"
brew "groff"
brew "help2man"
brew "alhadis/troff/man-db" if OS.mac?
brew "multimarkdown"
brew "pandoc"
brew "qpdf"

# audio/video
brew "atomicparsley"
brew "id3v2"
brew "mkvtoolnix"
brew "mp3info"
brew "mp4v2"
brew "yt-dlp"

# images
brew "imagemagick"
brew "imagesnap" if OS.mac?
brew "webkit2png" if OS.mac?
brew "webp"

# internet stuff
tap "homebrew/services"
brew "dnsmasq", restart_service: :changed if OS.mac?
brew "ssh-copy-id", link: true

# JavaScript
brew "node"
brew "coffeescript"
brew "typescript"
brew "yarn"

# (Dart) Sass
brew "sass/sass/sass"

# web fonts
brew "fontforge"
brew "bramstein/webfonttools/sfnt2woff-zopfli"
brew "bramstein/webfonttools/sfnt2woff"
brew "bramstein/webfonttools/woff2"

# VS Code extensions
brew "shellcheck"
brew "shfmt"

# fun, games
brew "fastfetch"
brew "lolcat"
brew "nethack"

# other stuff
brew "zgracem/formulae/calendar"
brew "zgracem/formulae/unrar"
