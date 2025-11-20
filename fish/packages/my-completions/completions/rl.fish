function __fish_complete_rl
    set -f output

    # Add sourceable files
    set -f envdirs $XDG_CONFIG_HOME ~/.private $__fish_config_dir
    set -f envfiles (path basename -E $envdirs/env.d/*.{env,fish})
    set -a output $envfiles\t.env\n

    set -f conffiles (path basename -E $__fish_config_dir{,/**/conf.d}/*.fish)
    set -a output $conffiles\tfile\n

    # Add function names
    set -f funcs (functions -n)
    set -a output $funcs\tfunction\n

    # Add completion definitions
    set -f comps (path basename -E $fish_complete_path/*.fish)
    set -a output $comps\tcompletion\n

    echo -ns $output | path sort -u
end

complete -c rl -n "__fish_is_nth_token 1" -xa "(__fish_complete_rl)"
complete -c rl -s v -l verbose -d "Verbose output"
