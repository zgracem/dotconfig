function rlcode -d "Reload Visual Studio Code with the current environment"
    osascript -e 'tell application "Visual Studio Code" to quit'
    sleep 1

    killall Dock
    and sleep 1

    and open -b com.microsoft.VSCode
end
