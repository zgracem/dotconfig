set -p fish_function_path "$__fish_config_dir/prompt"

# base paths
set --export PATH /usr/bin /bin /usr/sbin /sbin
set --export MANPATH /usr/share/man /usr/man

# /usr/local
set -p PATH /usr/local/bin /usr/local/sbin
set -p MANPATH /usr/local/share/man

# Homebrew
if [ -x /usr/local/bin/brew ]
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

if linux?
  for d in $HOME/.linuxbrew /home/linuxbrew/.linuxbrew
    if [ -x $d/bin/brew ]
      set -p PATH $d/bin $d/sbin
      set -p MANPATH $d/share/man
      break
    end
  end
  set --erase d
end

# $HOME
set -p PATH $HOME/opt/bin $HOME/bin
set -p MANPATH $HOME/opt/share/man $HOME/opt/man

# rbenv
if [ -d "$HOME/.rbenv" ]
  if [ -d "$HOME/.rbenv/bin" ]
    # non-Homebrew installation
    set -p PATH $HOME/.rbenv/bin
  end
  set -p PATH $HOME/.rbenv/shims
  set -p MANPATH $HOME/.rbenv/versions/(cat "$HOME/.rbenv/version")/share/man
end

set PATH (__fish_path_fixer $PATH)
set MANPATH (__fish_path_fixer $MANPATH)
