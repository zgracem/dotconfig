_inPath exa || return

unalias ls ll 2>/dev/null
unset -f ls ll lsf

exa()
{
  command exa "$@"
}

ls()
{
  exa --all --classify "$@"
}

ll()
{
  ls --long --group --time-style=long-iso "$@"
}

lsf()
{
  ll --inode --extended
}

## -----------------------------------------------------------------------------

unset LS_COLORS
# export EXA_COLORS="$LS_COLORS:"
export EXA_COLORS=""

### PERMISSIONS

## User +r bit
EXA_COLORS+="ur=1;33:"
## User +w bit
EXA_COLORS+="uw=1;31:"
## User +x bit (files)
EXA_COLORS+="ux=1;4;32:"
## User +x bit (file types)
EXA_COLORS+="ue=1;32:"
## Group +r bit
EXA_COLORS+="gr=33:"
## Group +w bit
EXA_COLORS+="gw=31:"
## Group +x bit
EXA_COLORS+="gx=32:"
## Others +r bit
EXA_COLORS+="tr=33:"
## Others +w bit
EXA_COLORS+="tw=31:"
## Others +x bit
EXA_COLORS+="tx=32:"
## Higher bits (files)
# EXA_COLORS+="su="
## Higher bits (other types)
# EXA_COLORS+="sf="
## Extended attribute marker
EXA_COLORS+="xa=1;37:"

### FILE SIZES

## Size numbers
EXA_COLORS+="sn=36:"
## Size unit
EXA_COLORS+="sb=1;36:"
## Major device ID
EXA_COLORS+="df=1;36:"
## Minor device ID
EXA_COLORS+="ds=36:"

### OWNERS AND GROUPS

## A user that’s you
EXA_COLORS+="uu=32:"
## A user that’s not
EXA_COLORS+="un=33:"
## A group with you in it
EXA_COLORS+="gu=32:"
## A group without you
EXA_COLORS+="gn=33:"

### HARD LINKS

## Number of links
# EXA_COLORS+="lc="
## A multi-link file
# EXA_COLORS+="lm="

### GIT

## New
EXA_COLORS+="ga=1;32:"
## Modified
EXA_COLORS+="gm=1;33:"
## Deleted
EXA_COLORS+="gd=1;31:"
## Renamed
EXA_COLORS+="gv=36:"
## Type change
EXA_COLORS+="gt=36:"

### DETAILS AND METADATA

## Punctuation
# EXA_COLORS+="xx="
## Timestamp
# EXA_COLORS+="da="
## File inode
# EXA_COLORS+="in="
## Number of blocks
# EXA_COLORS+="bl="
## Table header row
EXA_COLORS+="hd=4;37:"
# Symlink path
EXA_COLORS+="lp=35:"
## Control character
EXA_COLORS+="cc=1;31:"

### OVERLAYS

## Broken link path
EXA_COLORS+="bO=45:"
