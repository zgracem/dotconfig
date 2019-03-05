# XDG base directories
# * https://specifications.freedesktop.org/basedir-spec/latest/ar01s02.html
# * https://wiki.archlinux.org/index.php/XDG_Base_Directory

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/var/cache
set -gx XDG_RUNTIME_DIR $HOME/var/run

# XDG user directories
# * https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
# * https://wiki.archlinux.org/index.php/XDG_user_directories

# read defaults from ~/.config/user-dirs.dirs
while read line
  set -l pattern '^(XDG_[[:upper:]]+_DIR)="([^"]+)"$'
  if string match -rq $pattern "$line"
    eval "export $line"
  end
end < $XDG_CONFIG_HOME/user-dirs.dirs

# Cygwin/MSYS
if uname -s | string match -q '*_NT-*'
  set user_profile
  if test -n "$USERPROFILE"
    set user_profile (cygpath -au $USERPROFILE)
  else
    switch (uname -s)
    case 'CYGWIN*'
      set user_profile /cygdrive/c/Users/$USER
    case 'MSYS*'
      set user_profile /c/Users/$USER
    end
    set -gx USERPROFILE (cygpath -aw $user_profile)
  end

  set -gx XDG_DESKTOP_DIR "$user_profile/Desktop"
  set -gx XDG_DOCUMENTS_DIR "$user_profile/My Documents"
  set -gx XDG_DOWNLOAD_DIR "$user_profile/Downloads"
  set -gx XDG_MUSIC_DIR "$user_profile/Music"
  set -gx XDG_PUBLICSHARE_DIR (cygpath -au "$PUBLIC")
  set -gx XDG_VIDEOS_DIR "$user_profile/Videos"

  switch $hostname
  case 'WS*'
    set -gx XDG_DOCUMENTS_DIR (cygpath -au "$HOMESHARE\\My Documents")
    set -gx XDG_DOWNLOAD_DIR $HOME/tmp
    set -gx XDG_MUSIC_DIR "$XDG_DOCUMENTS_DIR/My Music"
    set -gx XDG_PICTURES_DIR "$XDG_DOCUMENTS_DIR/My Pictures"
    set -gx XDG_VIDEOS_DIR "$XDG_DOCUMENTS_DIR/My Videos"
  end
end

# Linux
if uname -s | string match -q 'Linux'
  set -gx XDG_DESKTOP_DIR $HOME/.desktop
  set -gx XDG_DOCUMENTS_DIR $HOME/doc
  set -gx XDG_DOWNLOAD_DIR $HOME/tmp
end
