# Overrides $__fish_data_dir/functions/prompt_hostname.fish
if not functions -q __fish_prompt_hostname
    fish_source_data_file functions/prompt_hostname.fish
    functions --copy prompt_hostname __fish_prompt_hostname
end
function prompt_hostname --description 'short hostname for the prompt'
    switch (path extension $hostname)
        case .pink
            echo -n $hostname
        case '*'
            echo -n (__fish_prompt_hostname)
    end
end
