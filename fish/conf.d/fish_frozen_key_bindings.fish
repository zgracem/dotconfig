# fish < v4.3 shipped an event handler that runs
#   `set --universal fish_key_bindings fish_default_key_bindings`
# whenever the fish_key_bindings variable is erased.
# As a workaround, erase the universal variable at every shell startup.
set --erase --universal fish_key_bindings
