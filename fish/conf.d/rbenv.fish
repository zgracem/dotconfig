if in-path rbenv
  source (rbenv init - | psub)  # adds duplicate shims dir to PATH
end
