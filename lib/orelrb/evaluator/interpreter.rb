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

    def term
      token = @current_token
      eat(INTEGER)
      token.value
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
        raise_error
      end
    end

    def expr
      @current_token = get_next_token
      result = term
      while [PLUS, MINUS].include? @current_token.type
        token = @current_token
        if token.type == PLUS
          eat(PLUS)
          result = result + term
        end
        if token.type == MINUS
          eat(MINUS)
          result = result - term
        end
      end
      result
    end

    def raise_error
      raise 'Interpreter Error'
    end
  end
end
