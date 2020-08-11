def _match_keys(rx):
  [ keys[] | select( test(rx) ) ];
