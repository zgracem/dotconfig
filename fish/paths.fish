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
if is-macos; and in-path brew
    set -q HOMEBREW_PREFIX; or set -gx HOMEBREW_PREFIX (brew --prefix)
    # GNU coreutils (w/out `g` prefix)
    set -p PATH $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
    set -p MANPATH $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman

    # GNU findutils (w/out `g` prefix)
    set -p PATH $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
    set -p MANPATH $HOMEBREW_PREFIX/opt/findutils/share/man

    # GNU binutils
    set -p PATH $HOMEBREW_PREFIX/opt/binutils/bin
    set -p MANPATH $HOMEBREW_PREFIX/opt/binutils/share/man

    # GNU inetutils (w/out `g` prefix)
    set -p PATH $HOMEBREW_PREFIX/opt/inetutils/libexec/gnubin
    set -p MANPATH $HOMEBREW_PREFIX/opt/inetutils/share/man

    # GNU grep (w/out `g` prefix)
    set -p PATH $HOMEBREW_PREFIX/opt/grep/libexec/gnubin
    set -p MANPATH $HOMEBREW_PREFIX/opt/grep/share/man

    # GNU sed (w/out `g` prefix)
    set -p PATH $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
    set -p MANPATH $HOMEBREW_PREFIX/opt/gnu-sed/share/man

    # GNU tar (w/out `g` prefix)
    set -p PATH $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin
    set -p MANPATH $HOMEBREW_PREFIX/opt/gnu-tar/share/man

    # curl
    set -p PATH $HOMEBREW_PREFIX/opt/curl/bin
    set -p MANPATH $HOMEBREW_PREFIX/opt/curl/share/man

    # ncurses
    set -p PATH $HOMEBREW_PREFIX/opt/ncurses/bin
    set -p MANPATH $HOMEBREW_PREFIX/opt/ncurses/share/man

    # openjdk
    set -p PATH $HOMEBREW_PREFIX/opt/openjdk/bin

    # Xcode
    set -l XCODE /Applications/Xcode.app/Contents/Developer
    set -a PATH $XCODE/usr/bin
    set -a PATH $XCODE/Toolchains/XcodeDefault.xctoolchain/usr/bin
    set -a MANPATH $XCODE/usr/share/man
    set -a MANPATH $XCODE/Toolchains/XcodeDefault.xctoolchain/usr/share/man
    set -a MANPATH $XCODE/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man
end

# Linuxbrew
if is-linux
    for dir in ~/.linuxbrew /home/linuxbrew/.linuxbrew
        if path is -x $dir/bin/brew
            set -gx HOMEBREW_PREFIX $dir
            set -p PATH $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
            set -p MANPATH $HOMEBREW_PREFIX/share/man
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
if path is -d $XDG_DATA_HOME/rbenv
    if path is -d $XDG_DATA_HOME/rbenv/bin
        # non-Homebrew installation
        set -p PATH $XDG_DATA_HOME/rbenv/bin
    end
    read -l ruby_version <$XDG_DATA_HOME/rbenv/version
    set -p PATH $XDG_DATA_HOME/rbenv/shims
    set -p MANPATH $XDG_DATA_HOME/rbenv/versions/$ruby_version/share/man
end

# fish
set -p MANPATH $__fish_data_dir/man

# -----------------------------------------------------------------------------

fix-path PATH
fix-path MANPATH
