in-path exa; or exit

# Disable built-in colour mapping
set -gx --path EXA_COLORS reset

# Symbolic links (exa doesn't support "target")
set -a EXA_COLORS "ln="(get_color256 magenta)

# ----------------------------------------------------------------------------
# Permissions & ownership
# ----------------------------------------------------------------------------

# [u]ser/[g]roup/o[t]hers +
#   [r]ead/[w]rite/e[x]ecute (regular)/[e]xecute (other)
set -a EXA_COLORS "ur="(get_color256 brgreen)
set -a EXA_COLORS "uw="(get_color256 bryellow)
set -a EXA_COLORS "ux="(get_color256 brcyan)
set -a EXA_COLORS "ue="(get_color256 cyan)
set -a EXA_COLORS "gr="(get_color256 yellow)
set -a EXA_COLORS "gw="(get_color256 brred)
set -a EXA_COLORS "gx="(get_color256 cyan)
set -a EXA_COLORS "tr="(get_color256 yellow)
set -a EXA_COLORS "tw="(get_color256 brred)
set -a EXA_COLORS "tx="(get_color256 cyan)

# [s]etuid/setgid/sticky bits on reg[u]lar files & other [f]iles
set -a EXA_COLORS "su="(get_color256 cyan)
set -a EXA_COLORS "sf="(get_color256 cyan)

# [U]sers & [g]roups; yo[u] or [n]ot you
set -a EXA_COLORS "uu="(get_color256 green)
set -a EXA_COLORS "un="(get_color256 yellow)
set -a EXA_COLORS "gu="(get_color256 cyan)
set -a EXA_COLORS "gn="(get_color256 yellow)

# ----------------------------------------------------------------------------
# Attributes
# ----------------------------------------------------------------------------

# e[x]tended [a]ttributes
set -a EXA_COLORS "xa="(get_color256 white)

# File [s]ize: [n]umber & [b]yte unit
set -a EXA_COLORS "sn="(get_color256 cyan)
set -a EXA_COLORS "sb="(get_color256 cyan --bold)

# Number of blocks
set -a EXA_COLORS "bl="(get_color256 cyan)

# File date
set -a EXA_COLORS "da="(get_color256 white)

# inode number
set -a EXA_COLORS "in="(get_color256 normal)

# Device's major (df) and minor (ds) ID
set -a EXA_COLORS "df="(get_color256 cyan --bold)
set -a EXA_COLORS "ds="(get_color256 cyan)

# Hard links
set -a EXA_COLORS "lc="(get_color256 white)
set -a EXA_COLORS "lm="(get_color256 brwhite)

# ----------------------------------------------------------------------------
# Details & metadata
# ----------------------------------------------------------------------------

# git
set -a EXA_COLORS "ga="(get_color256 brgreen --bold)
set -a EXA_COLORS "gm="(get_color256 bryellow --bold)
set -a EXA_COLORS "gd="(get_color256 brred)
set -a EXA_COLORS "gv="(get_color256 cyan)
set -a EXA_COLORS "gt="(get_color256 cyan)

# Path of a symlink
set -a EXA_COLORS "lp="(get_color256 magenta)

# Overlay style for broken symlinks
set -a EXA_COLORS "bO="(get_color256 brred --bold)

# Header row of table
set -a EXA_COLORS "hd="(get_color256 white --underline)

# Punctuation
set -a EXA_COLORS "xx="(get_color256 brblack)

# Escape characters
set -a EXA_COLORS "cc="(get_color256 brblack)
