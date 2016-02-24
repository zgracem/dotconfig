htmlentity()
{
    if [[ $@ =~ ^\&(.+)\;$ ]]; then
        local entity=${BASH_REMATCH[1]}
    else
        local entity=$@
    fi

    ruby -r htmlentities -e "puts HTMLEntities.new.decode('&$@;')"
}
