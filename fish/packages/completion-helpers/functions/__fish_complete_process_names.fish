function __fish_complete_process_names
    set -l re '^\s*\d+\) "([^"\(]+).*".+'
    lsappinfo list | string match -rg $re | sort -u | while read -l proc
        string trim -r $proc
    end
end
