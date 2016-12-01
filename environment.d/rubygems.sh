if command -v gem >/dev/null; then
  export GEMRC="${XDG_CONFIG_HOME:-$HOME/.config}/ruby/gemrc"
  export GEM_SPEC_CACHE="${XDG_CACHE_HOME:-$HOME/var/cache}/gem/specs"
fi

if command -v bundle >/dev/null; then
  # Bundler should install binstubs to ~/opt/bin, not ~/bin
  export BUNDLE_BIN="$HOME/opt/bin"
fi

return 0
