def shared(with):
  with_entries( select( .key | in(with) ) );
