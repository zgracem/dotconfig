function my-prompt-jobs --description 'Helper function for fish_prompt'
    set -l job_count (builtin jobs -g | count)
    or return 0

    set_color $fish_prompt_color_jobs
    echo -n $job_count

    set_color normal
    echo -n " "
end
