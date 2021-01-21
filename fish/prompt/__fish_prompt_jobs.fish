function __fish_prompt_jobs --description 'Helper function for fish_prompt'
    set job_count (count (jobs))
    or return 0

    set_color $fish_prompt_color_jobs
    echo -n $job_count

    set_color normal
    echo -n " "
end
