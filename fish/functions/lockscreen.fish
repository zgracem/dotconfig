if is-macos
    function lockscreen --description 'Lock the screen'
        /System/Library/CoreServices/'Menu Extras'/User.menu/Contents/Resources/CGSession -suspend
    end
end
