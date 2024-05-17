# See also: ~/.config/env.d/macos.env
function sdkreset
    command -q xcrun; or return 127
    set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)
    and echo $SDKROOT
end
