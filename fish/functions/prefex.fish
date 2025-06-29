function prefex
     defaults export $argv[1] - | pyjamas --mode=plist:yaml | bat -p -lyaml
end
