# sips (macOS scriptable image processor system)

set -l sips_img_props_ro '
    pixelHeight\tinteger
    pixelWidth\tinteger
    typeIdentifier\tstring
    space\tstring
    samplesPerPixel\tinteger
    bitsPerSample\tinteger
    creation\tstring
    software\tstring
    hasAlpha\tboolean
'
set -l sips_img_props_rw '
    dpiHeight\tfloat
    dpiWidth\tfloat
    format\tstring
    formatOptions\tstring
    make\tstring
    model\tstring
    description\tstring
    copyright\tstring
    artist\tstring
    profile\tbinary
'
set -l sips_img_props_all $sips_img_props_ro\n$sips_img_props_rw

set -l sips_prof_props_ro '
    size\tinteger
    class\tstring
    space\tstring
    pcs\tstring
    md5\tstring
'
set -l sips_prof_props_rw '
    description\tstring
    cmm\tstring
    version\tstring
    creation\tstring
    platform\tstring
    quality\tstring
    deviceManufacturer\tstring
    deviceModel\tinteger
    deviceAttributes0\tinteger
    deviceAttributes1\tinteger
    renderingIntent\tstring
    creator\tstring
    copyright\tstring
'
set -l sips_prof_props_all $sips_prof_props_ro\n$sips_prof_props_rw

set -l sips_props_rw $sips_img_props_rw\n$sips_prof_props_rw
set -l sips_props_all $sips_img_props_all\n$sips_prof_props_all

# Profile query functions
complete -c sips -s g -l getProperty -x -a "$sips_props_all" -d "Output value for KEY"
complete -c sips -s X -l extractTag -x -d "Write TAG to FILE"
complete -c sips -l verify -d "Verify profile"
complete -c sips -s 1 -l oneLine -d "Output one line per file"

# Image query functions
complete -c sips -s x -l extractProfile -rF -d "Write embedded profile to FILE"

# Profile modification functions
complete -c sips -s s -l setProperty -x -a "$sips_props_rw" -d "Set KEY to VALUE"
complete -c sips -s d -l deleteProperty -x -a "$sips_props_rw" -d "Remove property for KEY"
complete -c sips -l deleteTag -x -d "Remove TAG from PROFILE"
complete -c sips -l copyTag -x -d "Copy SOURCE tag to DEST"
complete -c sips -l loadTag -x -d "Set TAG to contents of FILE"
complete -c sips -l repair -d "Repair profile"
complete -c sips -s o -l out -rF -d "Output file or directory"

# Image modification functions
complete -c sips -s e -l embedProfile -x -d "Embed PROFILE in image"
complete -c sips -s E -l embedProfileIfNone -x -d "Embed PROFILE only if image has none"
complete -c sips -s m -l matchTo -x -d "Color match to PROFILE"
complete -c sips -s M -l matchToWithIntent -x -d "Color match to PROFILE with INTENT" # perceptual | relative | saturation | absolute
complete -c sips -l deleteColorManagementProperties -d "Delete color management properties"
complete -c sips -s r -l rotate -x -d "Rotate DEGREES clockwise"
complete -c sips -s f -l flip -x -a "horizontal vertical" -d "Flip image"
complete -c sips -s c -l cropToHeightWidth -x -d "Crop to HEIGHT and WIDTH"
complete -c sips -l cropOffset -x -d "Crop offset Y and X from top left"
complete -c sips -s p -l padToHeightWidth -x -d "Pad image to fit HEIGHT and WIDTH"
complete -c sips -l padColor -x -d "Use COLOR when padding"
complete -c sips -s z -l resampleHeightWidth -x -d "Resample to HEIGHT and WIDTH"
complete -c sips -l resampleWidth -x -d "Resample to WIDTH"
complete -c sips -l resampleHeight -x -d "Resample to HEIGHT"
complete -c sips -s Z -l resampleHeightWidthMax -x -d "Resample to max SIZE"
complete -c sips -s i -l addIcon -d "Add Finder icon to image file"
complete -c sips -l optimizeColorForSharing -d "Optimize color for sharing"
complete -c sips -s j -l js -rF -d "Execute JavaScript FILE"

# Other functions
complete -c sips -l debug -d "Enable debugging output"
complete -c sips -s h -l help -d "Show help"
complete -c sips -s H -l helpProperties -d "Show help for properties"
complete -c sips -l man -d "Generate man pages"
complete -c sips -s v -l version -d "Show the version"
complete -c sips -l formats -d "Show the read/write formats"
