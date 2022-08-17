for token_file in ~/.private/tokens/*
    string match -rq '^[A-Z_]+$' (basename $token_file); or continue
    read -gx (basename $token_file) <$token_file
end
