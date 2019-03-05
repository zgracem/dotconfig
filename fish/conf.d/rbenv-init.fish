if in-path rbenv
  source (rbenv init - | psub)
  __fish_fix_path PATH
end
