# A control sequence for setting the terminal's colour and style of text.
class EscSeq
  # @return [String] Control Sequence Introducer
  CSI = "\e["

  # @params [Array<Integer>]
  def initialize(*params)
    @sequence = params.map(&:to_i)
  end

  # @return [String]
  def to_s
    empty? ? "" : to_string
  ensure
    reset!
  end
  # alias_method :to_str, :to_s

  # @return [Boolean]
  def empty?
    sequence.empty?
  end

  # @return [self]
  def append(*params)
    sequence.append(*params)
    self
  end

  # @return [self]
  def prepend(*params)
    sequence.prepend(*params)
    self
  end

  # @return [String]
  def inspect
    to_string.dump
  end

  # @return [self]
  def reset!
    sequence.replace([])
    self
  end

  private

  # @return [Array<Integer>]
  attr_accessor :sequence

  # @return [String]
  def to_string
    format "%s%sm", CSI, sequence.join(";")
  end
end
