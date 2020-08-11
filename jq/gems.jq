module {
  name: "gems",
  description: "Returns a simple test object with information about gemstones",
  input: "void",
  output: "object"
};

import "gems_data" as $GEMS;
def gems:
  ($GEMS::GEMS | first);
