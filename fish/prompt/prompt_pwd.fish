function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
    set -q argv[1]
    or set -l argv[1] (pwd)

    # Show this many characters in abbreviated components
    set -q fish_prompt_pwd_length
    or set -l fish_prompt_pwd_length 3

    # Keep this many trailing components unabbreviated
    set -q fish_prompt_pwd_keep
    or set -l fish_prompt_pwd_keep 1

    # Use this character to indicate shortened components
    set -q fish_prompt_pwd_glyph
    or set -l fish_prompt_pwd_glyph "…"

    set -l cwd (short_home $argv[1])
    set -l cwd_parts (string split "/" "$cwd")

    if test (count $cwd_parts) -le $fish_prompt_pwd_keep
        echo $cwd
        return 0
    else
        for i in (seq 1 (math (count $cwd_parts) - $fish_prompt_pwd_keep))
            if test (string length $cwd_parts[$i]) -gt (math $fish_prompt_pwd_length + 1)
                set cwd_parts[$i] (string sub -l $fish_prompt_pwd_length "$cwd_parts[$i]")"$fish_prompt_pwd_glyph"
            end
        end
    end

    string join / -- $cwd_parts
end
