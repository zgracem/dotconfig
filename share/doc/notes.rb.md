## notes.rb

### `include`/`extend` cheat sheet

```ruby
module Included
  # Included constants become available to the including class.
  INC = :in

  # Included methods become instance methods.
  def included_method
    :included
  end
end

module Extended
  # Extended constants are not available to the extending class.
  EXC = :out

  # Extended methods become class methods.
  def extended_method
    :extended
  end
end

class Klassy
  include Included
  extend Extended
end

puts Klassy.new.included_method #=> :included
puts Klassy.extended_method     #=> :extended
puts Klassy::INC                #=> :in
puts Klassy::EXC                #=> NameError, uninitialized constant
```
