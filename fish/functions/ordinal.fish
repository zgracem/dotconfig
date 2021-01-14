function ordinal -a number
    set -l suffix th
    switch $number
        case "*11" "*12" "*13"
            set suffix th
        case "*1"
            set suffix st
        case "*2"
            set suffix nd
        case "*3"
            set suffix rd
    end

    echo -s $number $suffix
end
