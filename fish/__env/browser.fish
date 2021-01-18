set -gx BROWSER

# Set default browser to links, if available
command -sq links; and set BROWSER links

# Use GUI app if not logged in remotely
if not set -q SSH_CONNECTION
    if is-cygwin
        # Wrapper script for Firefox
        set BROWSER "$HOME/bin/firefox"
    else
        set BROWSER (type -P open)
    end
end
