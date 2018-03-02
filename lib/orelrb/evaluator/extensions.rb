class String
  def number?
    Integer(self).is_a?(Integer)
  rescue ArgumentError, TypeError
    false
  end
end
