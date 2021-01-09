function preftouch
    set -l pref_dir ~/Dropbox/Projects/flannel/defaults
    for domain in $argv
        touch $pref_dir/$domain.yaml
    end
end
