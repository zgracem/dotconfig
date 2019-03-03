# Because $__fish_data_dir/config.fish emulates path_helper(8) on macOS and
# reads the contents of /etc/{,man}paths{,.d} -- and we want the contents of
# those so we don't have to go digging ourselves -- we start by prepending to
# whatever PATH is already set. Duplicate entries will be removed later by
# __fish_path_fixer, with our settings here taking precedence.

set --export PATH /usr/bin /bin /usr/sbin /sbin $PATH
set --export MANPATH /usr/share/man /usr/man $MANPATH

# /usr/local
set -p PATH /usr/local/bin /usr/local/sbin
set -p MANPATH /usr/local/share/man

# Homebrew
if macos?; and test -x /usr/local/bin/brew
  # GNU coreutils (w/out `g` prefix)
  set -p PATH /usr/local/opt/coreutils/libexec/gnubin
  set -p MANPATH /usr/local/opt/coreutils/libexec/gnuman

  # GNU sed (w/out `g` prefix)
  set -p PATH /usr/local/opt/gnu-sed/libexec/gnubin
  set -p MANPATH /usr/local/opt/gnu-sed/share/man

  # GNU tar (w/out `g` prefix)
  set -p PATH /usr/local/opt/gnu-tar/libexec/gnubin
  set -p MANPATH /usr/local/opt/gnu-tar/share/man

  # man-db (w/out `g` prefix)
  set -p PATH /usr/local/opt/man-db/libexec/bin
  set -p MANPATH /usr/local/opt/man-db/share/man

  # GNU i18n/l10n utilities
  set -p PATH /usr/local/opt/gettext/bin
  set -p MANPATH /usr/local/opt/gettext/share/man

  # ncurses
  set -p PATH /usr/local/opt/ncurses/bin
  set -p MANPATH /usr/local/opt/ncurses/share/man
end

# Linuxbrew
if linux?
  for dir in $HOME/.linuxbrew /home/linuxbrew/.linuxbrew
    if test -x $dir/bin/brew
      set -p PATH $dir/bin $dir/sbin
      set -p MANPATH $dir/share/man
      break
    end
  end
  set --erase dir
end

# $HOME
set -p PATH $HOME/opt/bin $HOME/bin
set -p MANPATH $HOME/opt/share/man $HOME/opt/man

# rbenv
if test -d "$HOME/.rbenv"
  if test -d "$HOME/.rbenv/bin"
    # non-Homebrew installation
    set -p PATH $HOME/.rbenv/bin
  end
  set -p PATH $HOME/.rbenv/shims
  set -p MANPATH $HOME/.rbenv/versions/(cat "$HOME/.rbenv/version")/share/man
end

# fish
set -p MANPATH $__fish_data_dir/man

# -----------------------------------------------------------------------------

set PATH (__fish_path_fixer $PATH)
set MANPATH (__fish_path_fixer $MANPATH)
