if command -v gem >/dev/null; then
  export GEMRC="${XDG_CONFIG_HOME:-$HOME/.config}/ruby/gemrc"
  export GEM_SPEC_CACHE="${XDG_CACHE_HOME:-$HOME/var/cache}/gem/specs"
fi

return 0
