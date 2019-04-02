# Because $__fish_data_dir/config.fish emulates path_helper(8) on macOS and
# reads the contents of /etc/{,man}paths{,.d} -- and we want the contents of
# those so we don't have to go digging ourselves -- we start by prepending to
# whatever PATH is already set. Duplicate entries will be removed later by
# __fish_fix_path, with our settings here taking precedence.

set --export PATH /usr/bin /bin /usr/sbin /sbin $PATH
set --export MANPATH /usr/share/man /usr/man $MANPATH

# /usr/local
set -p PATH /usr/local/bin /usr/local/sbin
set -p MANPATH /usr/local/share/man

# Homebrew
if test -d "$HOMEBREW_PREFIX"
  # use Homebrew's cURL if present
  set -p PATH $HOMEBREW_PREFIX/opt/curl/bin
end

if macos?; and test -x /usr/local/bin/brew
  # GNU coreutils (w/out `g` prefix)
  set -p PATH /usr/local/opt/coreutils/libexec/gnubin
  set -p MANPATH /usr/local/opt/coreutils/libexec/gnuman

  # GNU findutils (w/out `g` prefix)
  set -p PATH /usr/local/opt/findutils/libexec/gnubin
  set -p MANPATH /usr/local/opt/findutils/share/man

  # GNU grep (w/out `g` prefix)
  set -p PATH /usr/local/opt/grep/libexec/gnubin
  set -p MANPATH /usr/local/opt/grep/share/man

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
end

# Linuxbrew
if linux?
  for dir in ~/.linuxbrew /home/linuxbrew/.linuxbrew
    if test -x $dir/bin/brew
      set -p PATH $dir/bin $dir/sbin
      set -p MANPATH $dir/share/man
      break
    end
  end
  set --erase dir
end

# $HOME
set -p PATH ~/opt/bin ~/bin
set -p MANPATH ~/opt/share/man ~/share/man

# rbenv
if test -d ~/.rbenv
  if test -d ~/.rbenv/bin
    # non-Homebrew installation
    set -p PATH ~/.rbenv/bin
  end
  set -p PATH ~/.rbenv/shims
  set -p MANPATH ~/.rbenv/versions/(cat ~/.rbenv/version)/share/man
end

# fish
set -p MANPATH $__fish_data_dir/man

# -----------------------------------------------------------------------------

__fish_fix_path PATH
__fish_fix_path MANPATH
