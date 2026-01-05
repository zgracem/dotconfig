# If fish_user_paths is a universal variable: ignore, preserve, and remove it.
if set -Uq fish_user_paths
    set -l timestamp (date +%s)
    echo >&2 -s (set_color brred) "fish_user_paths -> fish_user_paths_$timestamp" (set_color normal)
    set -U fish_user_paths_$timestamp $fish_user_paths
    and set -U --erase fish_user_paths
end

# Set as global to prevent fish_add_path from (re-)setting it as universal.
set -gx fish_user_paths

# ----------------------------------------------------------------------------

# Check $HOME for missing args to `cd`
set -gx CDPATH . ~

# Remove duplicate and non-existent directories added by /etc/paths.d
set -gx PATH (path filter -d $PATH | un1q)

# Basic
set -gx MANPATH /usr/share/man

# /usr/local
fish_add_path /usr/local/bin
fish_add_manpath /usr/local/share/man

# Homebrew
if path is -d $HOMEBREW_PREFIX # set in conf.d/___dirs.fish
    fish_add_path $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
    fish_add_manpath $HOMEBREW_PREFIX/share/man

    # GNU coreutils (w/out `g` prefix)
    fish_add_path $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
    fish_add_manpath $HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman

    # GNU findutils (w/out `g` prefix)
    fish_add_path $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
    fish_add_manpath $HOMEBREW_PREFIX/opt/findutils/share/man

    # GNU inetutils (w/out `g` prefix)
    fish_add_path $HOMEBREW_PREFIX/opt/inetutils/libexec/gnubin
    fish_add_manpath $HOMEBREW_PREFIX/opt/inetutils/share/man

    # GNU grep (w/out `g` prefix)
    fish_add_path $HOMEBREW_PREFIX/opt/grep/libexec/gnubin
    fish_add_manpath $HOMEBREW_PREFIX/opt/grep/share/man

    # GNU sed (w/out `g` prefix)
    fish_add_path $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
    fish_add_manpath $HOMEBREW_PREFIX/opt/gnu-sed/share/man

    # GNU tar (w/out `g` prefix)
    fish_add_path $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin
    fish_add_manpath $HOMEBREW_PREFIX/opt/gnu-tar/share/man

    # llvm
    #fish_add_path $HOMEBREW_PREFIX/opt/llvm/bin
    #fish_add_manpath $HOMEBREW_PREFIX/opt/llvm/share/man

    # curl
    fish_add_path $HOMEBREW_PREFIX/opt/curl/bin
    fish_add_manpath $HOMEBREW_PREFIX/opt/curl/share/man

    # ncurses
    fish_add_path $HOMEBREW_PREFIX/opt/ncurses/bin
    fish_add_manpath $HOMEBREW_PREFIX/opt/ncurses/share/man

    # calendar
    fish_add_path $HOMEBREW_PREFIX/opt/calendar/bin
    fish_add_manpath $HOMEBREW_PREFIX/opt/calendar/share/man
    set -gx CALENDAR_DIR ~/Developer/share/calendar/src

    # openjdk
    fish_add_path $HOMEBREW_PREFIX/opt/openjdk/bin

    # m4
    fish_add_path $HOMEBREW_PREFIX/opt/m4/bin
end

# npm
fish_add_path $XDG_DATA_HOME/npm/bin

# Xcode
set -l XCODE /Applications/Xcode.app/Contents/Developer
fish_add_path -a $XCODE/usr/bin
fish_add_manpath -a $XCODE/usr/share/man
fish_add_path -a $XCODE/Toolchains/XcodeDefault.xctoolchain/usr/bin
fish_add_manpath -a $XCODE/Toolchains/XcodeDefault.xctoolchain/usr/share/man
fish_add_manpath -a $XCODE/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/share/man
fish_add_manpath -a /Library/Developer/CommandLineTools/usr/share/man
fish_add_manpath -a /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man

# Cygwin
set -q LOCALAPPDATA
and fish_add_path -a (cygpath -au "$LOCALAPPDATA")"/Programs/Microsoft VS Code/bin"

# RasPi server
if is-raspi
    fish_add_path /usr/sbin
end

# rbenv
if path is -d $RBENV_ROOT
    # in case of non-Homebrew installation
    fish_add_path $RBENV_ROOT/bin

    fish_add_path $RBENV_ROOT/shims

    read -l ruby_version <$RBENV_ROOT/version
    and fish_add_manpath $RBENV_ROOT/versions/$ruby_version/share/man
end

# Perl local::lib
if path is -d $HOME/perl5
    fish_add_manpath $HOME/perl5/man
    eval "$(SHELL=fish perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
end

# fish builtins
fish_add_manpath $__fish_data_dir/man

# $HOME
fish_add_path $XDG_BIN_HOME ~/opt/bin
fish_add_manpath $XDG_DATA_HOME/man ~/opt/share/man

# Clean up
set PATH (path filter -d $PATH | un1q)
set MANPATH (path filter -d $MANPATH | un1q)
