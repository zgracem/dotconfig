function execbash --description 'GNU Bourne-Again SHell'
    set -gx PREFERRED_SHELL (type -P bash)
    exec bash
end
