require 'spec_helper'

module Codebreaker
  RSpec.describe Console do
    let(:console) {Console.new}
    context 'play' do
      describe 'should be able to call methods' do
        before do
          allow(console).to receive(:puts)
          allow(console).to receive(:gets).and_return('1234')
        end

        it 'call #code_checker' do
          expect(console.instance_variable_get(:@game)).to receive(:code_checker)
          console.play
        end
      end
    end
    context 'save_data' do
      it 'data.yaml should be present' do
        allow(console).to receive(:puts)
        allow(console).to receive(:gets).and_return('test')
        console.send(:save_data)
        expect(File.exist?('data.yaml')).to eq true
      end
    end

    context '#play_again' do
      before do
        allow(console).to receive(:play)
        allow(console).to receive(:gets).and_return('y')
      end

      it 'ask to play again' do
        expect { console.send(:play_again) }.to output(/Another try?/).to_stdout
      end

      it 'start new game' do
        allow(console).to receive(:puts)
        expect(Game).to receive(:new)
        console.send(:play_again)
      end

      it "call #play method" do
        allow(console).to receive(:puts)
        expect(console).to receive(:play)
        console.send(:play_again)
      end
    end
  end
end
