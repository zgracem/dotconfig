function fish_add_manpath --description "Add paths to the MANPATH"
    # See $__fish_data_dir/functions/fish_add_path.fish
    argparse -x g,U -x a,p g/global U/universal p/prepend a/append -- $argv
    or return

    set -l scope $_flag_global $_flag_universal
    set -q scope[1]; or set scope -g

    set -l var MANPATH

    set -l mode $_flag_prepend $_flag_append
    set -q mode[1]; or set mode -p

    for path in $argv
        set -l path (builtin realpath -s -- $path 2>/dev/null)
        # Skip non-existing paths
        path is -d $path; or continue
        # Skip pre-set paths
        contains -- $path $$var; and continue

        set $scope $mode $var $path
    end
end

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

# Remove duplicate and non-existent directories added by /etc/paths.d
set -gx PATH (path filter -d $PATH | un1q)

# Basic
set -gx MANPATH /usr/share/man

# /usr/local
fish_add_path /usr/local/bin
fish_add_manpath /usr/local/share/man

# npm
fish_add_path $XDG_DATA_HOME/npm/bin

# Homebrew
if path is -d /home/linuxbrew/.linuxbrew
    set -gx HOMEBREW_PREFIX /home/linuxbrew/.linuxbrew
    fish_add_path $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
    fish_add_manpath $HOMEBREW_PREFIX/share/man
end

# Homebrew
if command -q brew
    set -q HOMEBREW_PREFIX; or set -gx HOMEBREW_PREFIX (brew --prefix)

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

# rbenv
if source $XDG_CONFIG_HOME/env.d/rbenv.env
    # in case of non-Homebrew installation
    fish_add_path $RBENV_ROOT/bin

    fish_add_path $RBENV_ROOT/shims

    read -l ruby_version <$RBENV_ROOT/version
    and fish_add_manpath $RBENV_ROOT/versions/$ruby_version/share/man
end

# fish builtins
fish_add_manpath $__fish_data_dir/man

# $HOME
fish_add_path ~/bin ~/opt/bin ~/.local/bin
fish_add_manpath $XDG_DATA_HOME/man ~/opt/share/man

# Clean up
set PATH (path filter -d $PATH | un1q)
set MANPATH (path filter -d $MANPATH | un1q)
