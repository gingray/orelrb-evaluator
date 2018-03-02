module Orelrb::Evaluator
  class Token
    attr_accessor :type, :value

    def initialize type, value
      @type, @value = type, value
    end

    def to_s
      "Token(#{type}, #{value})"
    end
  end
end
