module Codebreaker
  class Game
    ATTEMPTS = 5
    HINTS = 1
    attr_reader :attempts, :hints

    def initialize
        @secret_code = code_generator
        @attempts = ATTEMPTS
        @hints = HINTS
    end

    def start
      @secret_code

    end

    private

    def code_generator
      code = Array.new(4)
      code.map { |e| rand(1..6) }.join
    end


  end
end
