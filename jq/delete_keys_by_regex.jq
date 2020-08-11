module {
  name: "delete_keys_by_regex",
  description: "Deletes all keys from the input that match a regexp",
  input: "object",
  output: "object",
  args: [
    {
      name: "rx",
      type: "string",
      description: "the regular expression to match the input's keys against"
    }
  ]
};
include "delete_keys";
include "_match_keys";
def delete_keys_by_regex(rx):
  delete_keys(_match_keys(rx));
