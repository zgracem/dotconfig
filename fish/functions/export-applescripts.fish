function export-applescripts -d "Export user scripts to plain text"
    for script in ~/Library/Scripts/**.scpt
        set -l ascript (path change-extension .applescript $script)
        if test $script -nt $ascript
            osadecompile $script >$ascript
            and echo $ascript
            or return
        end
    end
end
