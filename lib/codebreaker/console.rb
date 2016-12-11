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

      case guess = gets.chomp.downcase
        when 'hint'
          puts @game.hint
        when /^[1-6]{4}$/
          answer = @game.code_checker(guess)
          return if answer == '++++'
        when 'exit'
          return
      end

      return if @attempts == 0
      play_again
    end

    private

    def play_again
      puts "Another try? (y/n)"
      return if gets.chomp != 'y'
      @game = Game.new
      play
    end

    def save
      puts 'Would you like to save the game?(y/n)'
      save_data if gets.chomp.downcase! == 'y'
      return if gets.chomp.downcase! != 'y'
    end

    def save_data
      File.new('data.yaml', 'w')
      File.open('data.yaml', "w") do |f|
        f.write(get_score.to_yaml)
      end
    end

    def get_score
      score = @game.to_h
      puts 'What is your name?'
      score[:name] = gets.chomp.capitalize!
      stat = YAML.load_file('data.yaml') || []
      stat << score
    end
  end
end
