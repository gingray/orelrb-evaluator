class String
  def number?
    Integer(self).is_a?(Integer)
  rescue ArgumentError, TypeError
    false
  end

  def whitespace?
    self.strip.empty?
  end
end
