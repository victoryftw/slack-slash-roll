require 'spec_helper'
require './lib/actors/text_parser'
require './lib/actors/roller'
require './lib/actors/macro_roller'
require './lib/actors/macro_maker'

describe 'TextParser' do
  let(:user_name) { "Steve" }
  let(:command)    { "/roll" }
  let(:text)               { "  3d6 + 5 # a comment! " }

  let(:text_command)   { "3d6 + 5" }
  let(:comment)             { "a comment!" }

  let(:redis_url)       { "redis://example.com" }

  subject(:parser) { TextParser.new(
    player: user_name,
    command: command,
    text: text
  ) }

  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("REDIS_URL").and_return(redis_url)
  end

  describe '#process' do
    context 'when the text is a roll' do
      it 'returns the text thats passed in' do
        expect(Roller).to receive(:new).with(text: text_command, comment: comment).and_call_original

        expect(parser.process).to eq("15 (6, 5, 4) + 5 => 20 # a comment!")
      end
    end

    context 'when the text is a macro call' do
      let(:text) { "   sword-atk # a comment! " }
      let(:text_command)   { "sword-atk" }

      it 'returns the text thats passed in' do
        expect(MacroRoller).to receive(:new).with(text: text_command, comment: comment).and_call_original

        expect(parser.process).to eq(text_command)
      end
    end

    context 'when the text is a macro save' do
      let(:text) { "def sword-atk 3d6 + 5 # a comment! " }
      let(:text_command)   { "def sword-atk 3d6 + 5" }
      let(:mock_redis)  { double() }

      it 'returns the text thats passed in' do
        expect(Redis).to receive(:new).with(url: redis_url).and_return(mock_redis)
        expect(mock_redis).to receive(:set).with("sword-atk", "3d6 + 5 # a comment!")

        expect(MacroMaker).to receive(:new).with(text: text_command, comment: comment).and_call_original

        expect(parser.process).to eq("Macro 'sword-atk' set successfully!")
      end
    end
  end
end
