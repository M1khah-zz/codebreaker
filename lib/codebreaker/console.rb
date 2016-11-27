require "yaml"


module Codebreaker
  class Console
  def initialize
    @game = Game.new
  end

    def play
      puts "You wanna play? Lets play!"
      puts "Type 'hint' to get hint.Type 'exit' to quit"
      puts 'Try to guess 4 numbers in range from 1 to 6'

      while @attempts != 0
          guess = gets.chomp

          case guess
            when 'hint'
              puts @game.hint
            when /^[1-6]{4}$/
              answer = @game.code_checker(guess)
            when 'exit'
              return
          end
      end
    end
  end
end
