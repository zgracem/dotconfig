[ "$PLATFORM" = "windows" ] || return

# File extensions considered "executable" by cmd.com (minimal set)
if [ -z "$PATHEXT" ]; then
  PATHEXT=".COM;.EXE;.BAT"
fi

# Disable logging by Windows' Component Servicing Infrastructure
export windows_tracing_flags=0

# -----------------------------------------------------------------------------
# Default printer
# -----------------------------------------------------------------------------

printer_key='/proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device'

if [ -z "$PRINTER" ] && [ -e "$printer_key" ]; then
  read -r PRINTER < "$printer_key"
  export PRINTER="${PRINTER%%,*}"
fi

unset -v printer_key
