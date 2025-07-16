require_relative "esc_seq"

# @example
#   puts "Welcome to #{Colour.magenta}ruby#{Colour.reset}."
module Colour
  extend self

  # @return [Array<Symbol>]
  NAMES = %i[black red green yellow blue magenta cyan white].freeze

  # @return [Array<Symbol>]
  STYLES = %i[reset bold dim italic underline blink fastblink inverse].freeze

  # @!group Colour Methods

  # @!method black
  #   @return [self]
  # @!method red
  #   @return [self]
  # @!method green
  #   @return [self]
  # @!method yellow
  #   @return [self]
  # @!method blue
  #   @return [self]
  # @!method magenta
  #   @return [self]
  # @!method cyan
  #   @return [self]
  # @!method white
  #   @return [self]
  # @!method brightblack
  #   @return [self]
  # @!method brightred
  #   @return [self]
  # @!method brightgreen
  #   @return [self]
  # @!method brightyellow
  #   @return [self]
  # @!method brightblue
  #   @return [self]
  # @!method brightmagenta
  #   @return [self]
  # @!method brightcyan
  #   @return [self]
  # @!method brightwhite
  #   @return [self]
  NAMES.each_with_index do |name, idx|
    define_singleton_method(name) do
      offset = @background ? 40 : 30
      sequence.append(idx + offset)
      self
    end

    define_singleton_method("bright#{name}") do
      offset = @background ? 100 : 90
      sequence.append(idx + offset)
      self
    end
  end

  # Resets colour(s) to the terminal default.
  # @return [self]
  def default
    offset = @background ? 40 : 30
    sequence.append(9 + offset)
    self
  end

  # @!endgroup

  # @!group Attribute Methods

  # @!method bold
  #   @return [self]
  # @!method dim
  #   @return [self]
  # @!method italic
  #   @return [self]
  # @!method underline
  #   @return [self]
  # @!method blink
  #   @return [self]
  # @!method fastblink
  #   @return [self]
  #   @note Unlikely to be supported.
  # @!method inverse
  #   @return [self]
  # @!method nobold
  #   Disables both `bold` and `dim`
  #   @return [self]
  # @!method nodim
  #   Disables both `bold` and `dim`
  #   @return [self]
  # @!method noitalic
  #   @return [self]
  # @!method nounderline
  #   Disables both `underline` and `doubleunderline`
  #   @return [self]
  # @!method noblink
  #   Disables both `blink` and `fastblink`
  #   @return [self]
  # @!method noinverse
  #   @return [self]
  STYLES.each_with_index do |name, idx|
    define_singleton_method(name) do
      sequence.prepend(idx)
      self
    end

    case name
    when :reset, :fastblink
      next
    when :bold
      # `21` is *not* "not bold" -- this rarely-supported code turns on double
      # underlining (which can be turned off with `24`). Use `22` to deactivate
      # both bold (`1`) and dim (`2`) settings.
      define_singleton_method(:"no#{name}") do
        sequence.append(22)
        self
      end
    else
      define_singleton_method(:"no#{name}") do
        sequence.append(idx + 20)
        self
      end
    end
  end

  # @!method doubleunderline
  #   @return [self]
  #   @note Unlikely to be supported.
  define_singleton_method(:doubleunderline) do
    sequence.append(21)
    self
  end

  # Resets all attributes.
  # @return [self]
  def reset
    sequence.reset!
    sequence.append(0)
    self
  end

  # @!endgroup

  # Returns the current sequence, then empties the array.
  # @return [String]
  def to_s
    sequence.to_s
  ensure
    @sequence = EscSeq.new
    @background = false
  end

  # @return [String]
  def inspect
    sequence.inspect
  end

  # Specify background colour instead of foreground.
  # @return [self]
  def background
    @background = true
    self
  end
  alias_method :bg, :background

  # Toggle a previous use of {#background}.
  # @return [self]
  def foreground
    @background = false
    self
  end
  alias_method :fg, :foreground

  private

  # @return [EscSeq]
  def sequence
    @sequence ||= EscSeq.new
  end
end

# style = Colour.italic
# style = Colour.bg.brightblack.fg.brightwhite
# style = Colour.blue.bold
# style = Colour.brightgreen.background.green
# style = Colour.bg.brightblack.fg.brightwhite
# style = Colour.reset
# style = Colour.reset.default.background.default
# puts "#{style}hello world"
