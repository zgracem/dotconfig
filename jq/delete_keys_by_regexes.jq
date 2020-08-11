module {
  name: "delete_keys_by_regexes",
  description: "Deletes all keys from the input that match regexps in an array",
  input: "object",
  output: "object",
  args: [
    {
      name: "array_of_rxs",
      type: "array",
      description: "an array of regular expressions to match the input's keys against"
    }
  ]
};

include "delete_keys_by_regex";

def delete_keys_by_regexes(array_of_rxs):
  reduce array_of_rxs[] as $rx (.; delete_keys_by_regex($rx));
