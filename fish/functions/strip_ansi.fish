function strip_ansi --description 'Strips ANSI formatting escape codes from stdin'
    cat | string replace -ar "\x1b\[\d+(;\d+)*m" ""
end
