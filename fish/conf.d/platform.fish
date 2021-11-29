switch (uname -s)
    case Darwin
        set -gx PLATFORM "macOS"
    case "CYGWIN*"
        set -gx PLATFORM "Cygwin"
    case Linux
        set -gx PLATFORM "Linux"
    case Microsoft
        set -gx PLATFORM "WSL"
end

function is-macos --description 'Returns true if running on macOS'
    string match -q "macOS" $PLATFORM
end

function is-cygwin --description 'Returns true if running on Cygwin'
    string match -q "Cygwin" $PLATFORM
end

function is-linux --description 'Returns true if running on Linux'
    string match -q "Linux" $PLATFORM
end

function is-wsl --description 'Returns true if running on Windows Subsystem for Linux'
    string match -q "WSL" $PLATFORM
end
