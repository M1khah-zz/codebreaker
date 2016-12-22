require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    let(:game) {Game.new}
    context '#initialize' do

      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end
      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    context '#code_generator' do
      it 'generate 4 numbers' do
        expect(game.send(:code_generator).length).to eq(4)
      end
    end

    context '#code_checker' do
      array_of_answers = [
        ['1111', '1111', '++++'],
        ['1234', '4321', '----'],
        ['2363', '2366', '+++'],
        ['1234', '2345', '---'],
        ['3635', '3333', '++'],
        ['1234', '5513', '--'],
        ['1234', '5535', '+'],
        ['1234', '5525', '-'],
        ['1234', '4213', '+---'],
        ['1234', '2134', '++--'],
        ['1234', '5134', '++-'],
        ['1234', '5213', '+--'],
        ['1234', '1546', '+-'],
        ['1234', '5555', '']
      ]

      array_of_answers.each do |item|
         it "should return #{item[2]} if secret_code is #{item[0]} and player_code is #{item[1]}" do
           game.instance_variable_set(:@secret_code, item[0])
           expect(game.code_checker(item[1])).to eq item[2]
         end
      end

      it 'reduce attempts amount by 1' do
        expect{game.code_checker('1234')}.to change{game.attempts}.by(-1)
      end

      it 'returns warning if no attempts left'  do
        game.instance_variable_set(:@attempts,0)
        expect(game.code_checker('0000')).to eq('Game over')
      end
    end

    context '#marker' do
      it 'returns + if number and position guessed right' do
        game.instance_variable_set(:@secret_code,'1234')
        expect(game.code_checker('1234')).to eq('++++')
      end
    end


    context '#hint' do
      it 'reduce hints amount by 1' do
        expect{game.hint}.to change {game.hints}.by(-1)
      end


      it 'return warning message if no hints' do
        game.instance_variable_set(:@hints, 0)
        expect(game.hint).to eq("You dont have hints")
      end
    end


  end
end
