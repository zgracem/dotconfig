if command -v gem >/dev/null; then
  export GEMRC="$HOME/.config/ruby/gemrc"
fi

# keep homedir tidy
z_tidy ~/.gemrc 2>/dev/null

if command -v bundle >/dev/null; then
  # Bundler should install binstubs to ~/opt/bin, not ~/bin
  export BUNDLE_BIN="$HOME/opt/bin"
fi

return 0
