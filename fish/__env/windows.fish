string match -q "*_NT-*" (uname -s); or exit

# -----------------------------------------------------------------------------
# Shell variables
# ------------------------------------------------------------------------------

# If we have Windows admin privileges, we will be a member of group 544 or 0
set -l user_groups (id -G | string split " ")

if contains 0 $user_groups; or contains 544 $user_groups
    set -gx WINDOWS_ADMIN true
end

# File extensions considered "executable" by cmd.com (minimal set)
set -q PATHEXT; or set -gx PATHEXT ".COM;.EXE;.BAT"

# Disable logging by Windows' Component Servicing Infrastructure
set -gx windows_tracing_flags 0

# -----------------------------------------------------------------------------
# Import/adjust settings from CYGWIN environment variable
# -----------------------------------------------------------------------------

set -q CYGWIN; and set -gx CYGWIN (string split " " $CYGWIN)

# create Windows-native symlinks (if we have admin privileges)
if not string match -eq winsymlinks "$CYGWIN"
    if string match -q $WINDOWS_ADMIN true
        set -a CYGWIN winsymlinks:nativestrict
    else
        set -a CYGWIN winsymlinks:lnk
    end
end

# OSTYPE is not defined in POSIX
# shellcheck disable=SC2039
if string match -q $OSTYPE cygwin
    set -gx CYGWIN "$CYGWIN"
else if string match -q $OSTYPE msys
    set -gx MSYS "$CYGWIN"
    set --erase CYGWIN
end

# -----------------------------------------------------------------------------
# Default printer
# -----------------------------------------------------------------------------

set -l hkcu /proc/registry/HKEY_CURRENT_USER
set -l printer_key "$hkcu/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device"
if not set -q PRINTER; and test -e $printer_key
    string replace -r ',.*' '' <$printer_key | read -gx PRINTER
end
