function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
  set -q argv[1]; or set -l argv[1] (pwd)

  set -q fish_prompt_pwd_dir_length
  or set -l fish_prompt_pwd_dir_length 3

  set -q fish_prompt_pwd_dir_glyph
  or set -l fish_prompt_pwd_dir_glyph "…"

  set -l cwd (string replace -r "^$HOME(?=\$|/)" "~" $argv[1])
  set -l cwd_parts (string split "/" "$cwd")

  if [ (count $cwd_parts) -le 1 ]
    or [ (id -u) -eq 0 ] # root gets the unobscured path
    echo $cwd
    return 0
  else
    for i in (seq 1 (math (count $cwd_parts) - 1))
      if [ (string length $cwd_parts[$i]) -gt $fish_prompt_pwd_dir_length ]
        set cwd_parts[$i] (string sub -l $fish_prompt_pwd_dir_length "$cwd_parts[$i]")"$fish_prompt_pwd_dir_glyph"
      end
    end
  end

  string join "/" $cwd_parts
end
