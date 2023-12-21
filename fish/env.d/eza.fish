command -q eza
and not set -q __zgm_init_colours
or return

# Disable built-in colour mapping
set -Ux --path EZA_COLORS reset

# Symbolic links (eza doesn't support "target")
set -a EZA_COLORS "ln="(get_color256 magenta)

# ----------------------------------------------------------------------------
# Permissions & ownership
# ----------------------------------------------------------------------------

# [u]ser/[g]roup/o[t]hers +
#   [r]ead/[w]rite/e[x]ecute (regular)/[e]xecute (other)
set -a EZA_COLORS "ur="(get_color256 brgreen)
set -a EZA_COLORS "uw="(get_color256 bryellow)
set -a EZA_COLORS "ux="(get_color256 brcyan)
set -a EZA_COLORS "ue="(get_color256 cyan)
set -a EZA_COLORS "gr="(get_color256 yellow)
set -a EZA_COLORS "gw="(get_color256 brred)
set -a EZA_COLORS "gx="(get_color256 cyan)
set -a EZA_COLORS "tr="(get_color256 yellow)
set -a EZA_COLORS "tw="(get_color256 brred)
set -a EZA_COLORS "tx="(get_color256 cyan)

# [s]etuid/setgid/sticky bits on reg[u]lar files & other [f]iles
set -a EZA_COLORS "su="(get_color256 cyan)
set -a EZA_COLORS "sf="(get_color256 cyan)

# [U]sers & [g]roups; yo[u] or [n]ot you
set -a EZA_COLORS "uu="(get_color256 green)
set -a EZA_COLORS "un="(get_color256 yellow)
set -a EZA_COLORS "gu="(get_color256 cyan)
set -a EZA_COLORS "gn="(get_color256 yellow)

# ----------------------------------------------------------------------------
# Attributes
# ----------------------------------------------------------------------------

# e[x]tended [a]ttributes
set -a EZA_COLORS "xa="(get_color256 white)

# File [s]ize: [n]umber & [b]yte unit
set -a EZA_COLORS "sn="(get_color256 cyan)
set -a EZA_COLORS "sb="(get_color256 cyan --bold)

# Number of blocks
set -a EZA_COLORS "bl="(get_color256 cyan)

# File date
set -a EZA_COLORS "da="(get_color256 white)

# inode number
set -a EZA_COLORS "in="(get_color256 normal)

# Device's major (df) and minor (ds) ID
set -a EZA_COLORS "df="(get_color256 cyan --bold)
set -a EZA_COLORS "ds="(get_color256 cyan)

# Hard links
set -a EZA_COLORS "lc="(get_color256 white)
set -a EZA_COLORS "lm="(get_color256 brwhite)

# ----------------------------------------------------------------------------
# Details & metadata
# ----------------------------------------------------------------------------

# git
set -a EZA_COLORS "ga="(get_color256 brgreen --bold)
set -a EZA_COLORS "gm="(get_color256 bryellow --bold)
set -a EZA_COLORS "gd="(get_color256 brred)
set -a EZA_COLORS "gv="(get_color256 cyan)
set -a EZA_COLORS "gt="(get_color256 cyan)

# Path of a symlink
set -a EZA_COLORS "lp="(get_color256 magenta)

# Overlay style for broken symlinks
set -a EZA_COLORS "bO="(get_color256 brred --bold)

# Header row of table
set -a EZA_COLORS "hd="(get_color256 white --underline)

# Punctuation
set -a EZA_COLORS "xx="(get_color256 brblack)

# Escape characters
set -a EZA_COLORS "cc="(get_color256 brblack)
