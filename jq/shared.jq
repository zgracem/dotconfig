module {
  name: "shared",
  description: "Returns all entries shared between two objects",
  input: "object",
  output: "object",
  args: [
    {
      name: "with",
      type: "object",
      description: "the comparison object"
    }
  ]
};

def shared(with):
  with_entries( select( .key | in(with) ) );
