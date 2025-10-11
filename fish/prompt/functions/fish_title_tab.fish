function fish_title_tab --description 'Update the tab title'
    echo -ns (prompt_hostname) ":" (shortest_home $PWD)
end
