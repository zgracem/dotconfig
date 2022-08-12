function mv --description 'Move files'
    status is-interactive; and set -p argv -i # ask before overwriting
    set -p argv -v # verbose
    if is-macos
        # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
        /bin/mv $argv
    else
        command mv $argv
    end
end
