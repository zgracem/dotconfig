module {
  name: "delete_keys",
  description: "Deletes all keys from the input that match strings in an array",
  input: "object",
  output: "object",
  args: [
    {
      name: "array_of_keys",
      type: "array",
      description: "an array of keys to remove from the input"
    }
  ]
};

def delete_keys(array_of_keys):
  delpaths( [ array_of_keys[] | [.] ] );
