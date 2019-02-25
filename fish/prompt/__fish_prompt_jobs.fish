function __fish_prompt_jobs --description 'Helper function for fish_prompt'
  jobs >/dev/null; or return 0

  set job_count (jobs | wc -l)

  echo -n (set_color $__fish_prompt_color_jobs) "$job_count"
end
