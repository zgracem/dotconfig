set -p fish_function_path "$__fish_config_dir/prompt"

# base paths
set -x PATH /usr/bin /bin /usr/sbin /sbin
set -x MANPATH /usr/share/man /usr/man

# /usr/local
set -p PATH /usr/local/bin /usr/local/sbin
set -p MANPATH /usr/local/share/man

# GNU coreutils (w/out `g` prefix)
set -p PATH /usr/local/opt/coreutils/libexec/gnubin
set -p MANPATH /usr/local/opt/coreutils/libexec/gnuman

# GNU sed (w/out `g` prefix)
set -p PATH /usr/local/opt/gnu-sed/libexec/gnubin
set -p MANPATH /usr/local/opt/gnu-sed/share/man

# GNU tar (w/out `g` prefix)
set -p PATH /usr/local/opt/gnu-tar/libexec/gnubin
set -p MANPATH /usr/local/opt/gnu-tar/share/man

# GNU i18n/l10n utilities
set -p PATH /usr/local/opt/gettext/bin
set -p MANPATH /usr/local/opt/gettext/share/man

# ncurses
set -p PATH /usr/local/opt/ncurses/bin
set -p MANPATH /usr/local/opt/ncurses/share/man

# $HOME
set -p PATH $HOME/opt/bin $HOME/bin
set -p MANPATH $HOME/opt/share/man $HOME/opt/man

# rbenv
if test -d $HOME/.rbenv
  if test -d $HOME/.rbenv/bin
    # non-Homebrew installation
    set -p PATH $HOME/.rbenv/bin
  end
  set -p PATH $HOME/.rbenv/shims
  set -p MANPATH $HOME/.rbenv/versions/(cat "$HOME/.rbenv/version")/share/man
end
