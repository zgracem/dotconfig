# vim:ft=ruby

# development
brew "gcc" if OS.linux? # for Linuxbrew
if OS.mac?
  brew "autoconf"
  brew "cmake"
  brew "glib"
  brew "llvm"
  brew "texinfo"
end

# internet stuff
brew "links"
brew "lynx"
brew "youtube-dl"

# ruby
brew "taglib" # for taglib-ruby gem

# images
brew "exif"
brew "exiftool"
brew "pngcrush"

# ffmpeg with options
brew "homebrew-ffmpeg/ffmpeg/ffmpeg", args: %w[
  HEAD
  with-fdk-aac
  with-libssh
  with-openh264
  with-openssl
  with-rtmpdump
  with-two-lame
  with-webp
  with-xvid
]

# fun, games
brew "cowsay"
brew "ponysay"
brew "fortune"
brew "figlet"
