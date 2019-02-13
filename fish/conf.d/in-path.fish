function in-path --description 'Exits 0 if $1 is available in PATH'
  command -sq $argv[1] >/dev/null
end
