function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
  set -q fish_prompt_pwd_dir_length
  or set -l fish_prompt_pwd_dir_length 3

  set -q fish_prompt_pwd_dir_glyph
  or set -l fish_prompt_pwd_dir_glyph "…"

  set -l cwd_parts (pwd | string replace -r "^$HOME(?=\$|/)" "~" | string split "/")

  for i in (seq 1 (math (count $cwd_parts) - 1))
    if test (string length $cwd_parts[$i]) -gt $fish_prompt_pwd_dir_length
      set cwd_parts[$i] (string sub -l $fish_prompt_pwd_dir_length "$cwd_parts[$i]")"$fish_prompt_pwd_dir_glyph"
    end
  end

  string join "/" $cwd_parts
end
