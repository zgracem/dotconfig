# Create misc. objects for testing
module Sample
  module_function

  # @return [String]
  def string
    "Hëllő, wøŕ𝓁d!\n"
  end

  # @return [Hash]
  def hsh
    {
      red:    "ruby",
      green:  "emerald",
      blue:   "sapphire",
      violet: "amethyst",
      white:  "diamond"
    }
  end

  # @return [Array<String>]
  def array
    hsh.values
  end

  # @return [Integer]
  def integer
    rand(10..1000)
  end

  # @return [Float]
  def float
    rand(10.0..100.0)
  end

  # @return [Pathname]
  def pathname
    Pathname("~/Documents/blankpage.pdf").expand_path
  end

  # @return [Regexp]
  def regex
    /\A\h+\z/i
  end

  # @return [Set]
  def set
    Set.new(array.map(&:to_sym))
  end

  # @return [URI]
  def uri
    URI("https://user:p4s$w0rd@host.example.org:8443/path/to/resource.cgi?param=value#anchor")
  end
  alias_method :url, :uri

  # @return [Range]
  def range
    (4..20)
  end
end
