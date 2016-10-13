_inPath brew || return

# howto disable developer mode:
#   git -C "$(brew --repo)" config --unset homebrew.devcmdrun

# Pumpkin Spice Homebrew
# -- https://twitter.com/MacHomebrew/status/783028298351730688

if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
  printf -v month "%(%B)T"
else
  month="$(date +%B)"
fi

if [[ $month == "October" ]]; then
  export HOMEBREW_INSTALL_BADGE="\xf0\x9f\x8e\x83" # 🎃
fi

unset -v month
