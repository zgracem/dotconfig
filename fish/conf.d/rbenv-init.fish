if in-path rbenv
  source (rbenv init - | psub)  # adds duplicate shims dir to PATH
  __fish_fix_path PATH          # removes duplicate shims dir
end
