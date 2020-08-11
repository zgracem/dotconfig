module {
  name: "_match_keys",
  description: "Returns all keys from the input that match a regular expression",
  input: "object",
  output: "array",
  args: [
    {
      name: "rx",
      type: "string",
      description: "the regular expression to match the input's keys against"
      }
  ]
};

def _match_keys(rx):
  [ keys[] | select( test(rx) ) ];
