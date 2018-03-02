module Orelrb::Evaluator
  class Interpreter

    def initialize text
      @text = text
      @pos = 0
      @current_token = 1
      @current_char = @text[@pos]
    end


    def advance
      @pos+= 1
      if @pos > (@text.length - 1)
        @current_char = nil
      else
        @current_char = @text[@pos]
      end
    end

    def skip_whitespace
      while @current_char != nil && @current_char.whitespace?
        advance
      end
    end

    def integer
      result = ''
      while @current_char != nil && @current_char.number?
        result+= @current_char
        advance
      end
      result.to_i
    end

    def get_next_token
      while @current_char != nil
        if @current_char.whitespace?
          skip_whitespace
          next
        end

        if @current_char.number?
          return Token.new(INTEGER, integer)
        end

        if @current_char == '+'
          advance
          return Token.new(PLUS, '+')
        end

        if @current_char == '-'
          advance
          return Token.new(MINUS, '-')
        end
        raise_error
      end
      Token.new(EOF, nil)
    end

    def eat token_type
      if @current_token.type == token_type
        @current_token = get_next_token
      else
        binding.pry

        raise_error
      end
    end

    def expr
      @current_token = get_next_token
      left = @current_token
      eat(INTEGER)
      op = @current_token
      if op.type == PLUS
        eat(PLUS)
      else
        eat(MINUS)
      end
      right = @current_token
      eat(INTEGER)

      if op.type == PLUS
        result = left.value + right.value
      else
        result = left.value - right.value
      end
    end

    def raise_error
      raise 'Interpreter Error'
    end
  end
end
