if is-macos
    function mv --description 'Move files'
        # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
        set -p argv -i
        set -p argv -v
        /bin/mv $argv
    end
else
    function mv --description 'Move files'
        set -p argv -i
        set -p argv -v
        command mv $argv
    end
end
