function is-gnu --description 'Exits 0 if $1 uses GNU switches'
    command "$argv[1]" --version >/dev/null 2>&1
end
