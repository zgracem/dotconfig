if in-path rbenv
  eval (rbenv init -)
  set -g PATH (__fish_path_fixer $PATH)
end
