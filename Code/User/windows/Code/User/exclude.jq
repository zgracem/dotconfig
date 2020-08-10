import "exclude_extensions" as $FILTERS;

def _match_keys(exp):
  [ keys[] | select( test(exp) ) ];

def delete_keys(array_of_keys):
  delpaths( [ array_of_keys[] | [.] ] );

def delete_keys_by_regex(exp):
  delete_keys(_match_keys(exp));

def delete_keys_by_regexes(exps):
  reduce exps[] as $exp (.; delete_keys_by_regex($exp));

($FILTERS::FILTERS | first) as { keys: $keys, regexes: $regexes } |

delete_keys($keys) | delete_keys_by_regexes($regexes)
