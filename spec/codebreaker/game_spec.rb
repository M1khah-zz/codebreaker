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

      it 'return one number of secret code' do
        expect(game.instance_variable_get(:@secret_code)).to include(game.hint)
      end

      it 'return warning message if no hints' do
        game.instance_variable_set(:@hints, 0)
        expect(game.hint).to eq("You dont have hints")
      end
    end
  end
end
