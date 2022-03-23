# Because $__fish_data_dir/config.fish emulates path_helper(8) on macOS and
# reads the contents of /etc/{,man}paths{,.d}, we want the contents of
# those so we don't have to go digging ourselves. Add typical defaults at the
# end in case something weird has gone wrong.
set --export PATH $PATH /usr/bin /bin /usr/sbin /sbin
set --export MANPATH $MANPATH /usr/share/man /usr/man

# Now we start prepending to whatever PATH is already set. Duplicate entries
# will be removed later by fix-path, with our settings here taking precedence.
set -p PATH /usr/local/bin /usr/local/sbin
set -p MANPATH /usr/local/share/man

# Homebrew
if test -d "$HOMEBREW_PREFIX"
    # use Homebrew's cURL if present
    set -p PATH $HOMEBREW_PREFIX/opt/curl/bin
end

if is-macos; and test -x /usr/local/bin/brew
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

    # curl
    set -p PATH /usr/local/opt/curl/bin
    set -p MANPATH /usr/local/opt/curl/share/man

    # ncurses
    set -p PATH /usr/local/opt/ncurses/bin
    set -p MANPATH /usr/local/opt/ncurses/share/man

    # openjdk
    set -p PATH /usr/local/opt/openjdk/bin

    # Xcode
    set -a PATH /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
    set -a MANPATH /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man
    set -a MANPATH /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man
end

# Linuxbrew
if is-linux
    for dir in ~/.linuxbrew /home/linuxbrew/.linuxbrew
        if test -x $dir/bin/brew
            set -p PATH $dir/bin $dir/sbin
            set -p MANPATH $dir/share/man
            break
        end
    end
end

# npm
set -p PATH $XDG_DATA_HOME/npm/bin

# $HOME
set -p PATH ~/opt/bin ~/bin
set -p MANPATH ~/opt/share/man ~/share/man

# rbenv
if test -d ~/.rbenv
    if test -d ~/.rbenv/bin
        # non-Homebrew installation
        set -p PATH ~/.rbenv/bin
    end
    read -l ruby_version <~/.rbenv/version
    set -p PATH ~/.rbenv/shims
    set -p MANPATH ~/.rbenv/versions/$ruby_version/share/man
end

# fish
set -p MANPATH $__fish_data_dir/man

# -----------------------------------------------------------------------------

fix-path PATH
fix-path MANPATH
