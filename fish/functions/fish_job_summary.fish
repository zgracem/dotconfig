# Overrides $__fish_data_dir/functions/fish_job_summary.fish
function fish_job_summary -a job_id is_foreground cmd_line signal_or_end_name signal_desc proc_pid proc_name
    if test "$signal_or_end_name" = SIGINT; and test $is_foreground -eq 1
        return
    end

    set -l max_cmd_len 40
    set cmd_line (string shorten -m$max_cmd_len -- $cmd_line | string collect)

    # formatting
    set job_id (set_color $fish_color_prompt_jobs)"#$job_id"(set_color normal)
    set cmd_line (echo $cmd_line | fish_indent -i --ansi | string join "; ")
    set signal_or_end_print (set_color $fish_color_status)$signal_or_end_name(set_color normal)

    set -l message
    switch $signal_or_end_name
        case STOPPED ENDED
            set message (printf "fish: job %s %s: { %s}\n" \
                $job_id (string lower $signal_or_end_name) $cmd_line)
        case 'SIG*'
            if test -n "$proc_pid"
                set proc_name (set_color $fish_color_command)$proc_name(set_color normal)
                set message (printf "fish: %s terminated pid %s (%s) from job %s: { %s}\n" \
                    $signal_or_end_print $proc_pid $proc_name $job_id $cmd_line)
            else
                set message (printf "fish: %s terminated job %s: { %s}\n" \
                    $signal_or_end_print $job_id $cmd_line)
            end
    end

    if test $is_foreground -eq 0; and test $signal_or_end_name != STOPPED
        __fish_echo string join \n -- $message
    else
        string join \n -- $message >&2
    end | string trim
end
