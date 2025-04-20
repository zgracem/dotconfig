set -l exclusive_256_args s system c cube g grey

complete -c 256colours -f
complete -c 256colours -s s -l system -n "__fish_complete_exclusives $exclusive_256_args" -d "Print 16 system colours only"
complete -c 256colours -s c -l cube -n "__fish_complete_exclusives $exclusive_256_args" -d "Print 6×6×6 colour cube only"
complete -c 256colours -s g -l grey -n "__fish_complete_exclusives $exclusive_256_args" -d "Print greyscale ramp only"
complete -c 256colours -s N -l numbers -n "not __fish_seen_argument -s N -l numbers" -d "Print SGR param numbers"
