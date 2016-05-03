cronsave()
{   # save a copy of the user's current crontab

	local dir="${HOME}/Archive/crontab"
  local file

  if (( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 42 )); then
    printf -v file "${dir}/crontab.%(%y%m%d.%H%M)T.txt" -1
  else
  	local file="${dir}/crontab.$(date +%y%m%d.%H%M).txt"
  fi

	if [[ ! -d $dir ]]; then
		mkdir -p "$dir"
	fi

	crontab -l \
	>| "$file"
}
