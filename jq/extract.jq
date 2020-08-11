module {
  name: "extract",
  description: "Returns an object with only the keys from an array",
  input: "object",
  output: "object",
  args: [
    {
      name: "array_of_keys",
      type: "array",
      description: "an array of keys to extract from the input"
    }
  ]
};

def extract(array_of_keys):
  [ { key: array_of_keys[], value: .[array_of_keys[]] } ]
  | from_entries;
