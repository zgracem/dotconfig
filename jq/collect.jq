module {
  name: "collect",
  description: "Collects all elements from the input in an array",
  output: "array"
};

def collect:
  reduce .[] as $x ([]; . + $x);
