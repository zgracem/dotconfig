if in-path rbenv
  source (rbenv init - | psub)
  set -g PATH (__fish_path_fixer $PATH)
end
