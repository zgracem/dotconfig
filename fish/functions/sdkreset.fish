# See also: ~/.config/env.d/macos.env
command -q xcrun; or return

function sdkreset
    set -gx SDKROOT (xcrun --sdk macosx --show-sdk-path)
    and echo $SDKROOT
end
