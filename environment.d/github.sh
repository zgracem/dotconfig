if command -v brew >/dev/null; then
  export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.private/tokens/HOMEBREW_GITHUB_API_TOKEN)
fi
