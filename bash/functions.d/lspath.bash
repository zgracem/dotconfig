lspath()
{ # list PATH dirs, or env. var. $1 -- any colon-separated list -- vertically
  local var="${1-PATH}"
  tr ':' '\n' <<< "${!var}"
}
