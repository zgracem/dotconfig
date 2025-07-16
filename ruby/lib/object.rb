class Object
  # Excludes methods common to all Ruby {Object}s
  # @return [Array<Symbol>]
  def my_methods
    (methods - common_methods).sort
  end

  private

  # @return [Array<Symbol>]
  def common_methods
    (Object.methods + Object.instance_methods)
  end
end
