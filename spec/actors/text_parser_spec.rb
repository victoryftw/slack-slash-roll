require 'spec_helper'
require './lib/actors/text_parser'
require './lib/actors/roller'
require './lib/actors/macro_roller'
require './lib/actors/macro_maker'

describe 'TextParser' do
  let(:user_name) { "Steve" }
  let(:command)    { "/roll" }
  let(:text)               { "3d6 + 5" }

  subject(:parser) { TextParser.new(
    player: user_name,
    command: command,
    text: text
  ) }

  describe '#process' do
    context 'when the text is a roll' do
      it 'returns the text thats passed in' do
        expect(Roller).to receive(:new).with(text: text).and_call_original

        expect(parser.process).to eq("15 (6, 5, 4) + 5 => 12")
      end
    end

    context 'when the text is a macro call' do
      let(:text) { "sword-atk" }

      it 'returns the text thats passed in' do
        expect(MacroRoller).to receive(:new).with(text: text).and_call_original

        expect(parser.process).to eq(text)
      end
    end

    context 'when the text is a macro save' do
      let(:text) { "def sword-atk 3d6 + 5" }

      it 'returns the text thats passed in' do
        expect(MacroMaker).to receive(:new).with(text: text).and_call_original

        expect(parser.process).to eq(text)
      end
    end
  end
end
