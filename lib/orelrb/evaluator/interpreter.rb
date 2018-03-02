module Orelrb::Evaluator
  class Interpreter

    def initialize text
      @text = text
      @pos = 0
      @current_token = 1
    end

    def get_next_token
      text = @text
      if @pos > (text.length - 1)
        return Token.new(EOF, nil)
      end

      current_char = text[@pos]

      if current_char.number?
        token = Token.new(INTEGER, Integer(current_char))
        @pos+= 1
        return token
      end

      if current_char == '+'
        token = Token.new(PLUS, current_char)
        @pos+= 1
        return token
      end

      raise_error
    end

    def eat token_type
      if @current_token.type == token_type
        @current_token = get_next_token
      else
        raise_error
      end
    end

    def expr
      @current_token = get_next_token
      left = @current_token
      eat(INTEGER)
      op = @current_token
      eat(PLUS)
      right = @current_token
      eat(INTEGER)

      result = left.value + right.value
    end

    def raise_error
      raise 'Interpreter Error'
    end
  end
end
