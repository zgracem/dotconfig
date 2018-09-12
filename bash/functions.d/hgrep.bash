hgrep()
{
  sed -E '$!N;s/^#([0-9]+)\n/'"${esc_dim}\\1:${esc_reset}"'/' "$HISTFILE"* \
  | grep -E --colour=auto "${@: -1}"
}
