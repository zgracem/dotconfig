def delete_keys_by_regexes(rxs):
  reduce rxs[] as $rx (.; delete_keys_by_regex($rx));
