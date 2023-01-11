# Overrides $__fish_data_dir/functions/prompt_hostname.fish
function prompt_hostname --description 'short hostname for the prompt'
    set -l domain (string split -m1 -f2 -r "." $hostname)
    switch $domain
        case local pink
            echo -n $hostname
        case '*'
            string replace -r "\..*" "" $hostname
    end
end
