complete -c download_depot -f
complete -c download_depot -s d -l dir -rFa "(__fish_complete_directories)" -d 'Where to place downloaded files'
complete -c download_depot -s o -l os -xa "windows macos linux" -d 'Which OS to download for'
complete -c download_depot -s n -l dry-run -d 'Download manifest only'
complete -c download_depot -s h -l help -d 'Display help'
