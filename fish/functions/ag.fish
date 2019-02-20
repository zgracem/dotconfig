function ag
	command ag \
      --nobreak --noheading \
      --color-path="34" --color-line-number="36" --color-match="1;4;35" \
      --hidden --ignore .git --skip-vcs-ignores \
      $argv
end
