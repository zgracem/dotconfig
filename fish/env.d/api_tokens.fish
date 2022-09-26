# For each file in ~/.private/tokens whose name matches `/^[A-Z_]+$/`, set a
# global exported variable with the name of the file and the value of its
# contents.
#
# To add a token:
# $ echo abcdefg1234567 > ~/.private/tokens/FOO_API_KEY
for token_file in ~/.private/tokens/*
    string match -rq '^[A-Z_]+$' (basename $token_file); or continue
    read -gx (basename $token_file) <$token_file
end
