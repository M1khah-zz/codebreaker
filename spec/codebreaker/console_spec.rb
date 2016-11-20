require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    let(:console) {Console.new}

    context 'play' do
      it 'greets the player' do
        expect(console.play).to output(/You wanna play? Lets play!/).to_stdout
      end
    end
  end
end
