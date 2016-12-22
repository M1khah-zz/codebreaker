module Codebreaker
  class Game
    ATTEMPTS = 5
    HINTS = 2
    attr_reader :attempts, :hints

    def initialize
        @secret_code = code_generator
        @attempts = ATTEMPTS
        @hints = HINTS
    end

    def code_checker(guess)
      return 'Game over' if @attempts == 0
      @attempts -= 1
      return '++++' if guess == @secret_code
      marker(@secret_code.chars, guess.chars)
    end

    def hint
      return "You dont have hints" if @hints == 0
      @secret_code[rand(4)] if @hints > 0
      @hints -= 1
    end

    def to_h
      {
        :secret_code => @secret_code,
        :attempts_left => @attempts,
        :hints_left => @hints,
      }
    end

    private

    def code_generator
      code = Array.new(4)
      code.map { |e| rand(1..6) }.join
    end

    def marker(code, guess)
      result = ''
      guess.map.with_index do |number, index|
        if number == code[index]
          code[index], guess[index] = nil
          result << '+'
        end
      end

      [code, guess].each(&:compact!)
      code.each do |number|
        if guess.include?(number)
          guess[guess.index(number)] = nil
          result << '-'
        end
      end
      result
    end
  end
end
