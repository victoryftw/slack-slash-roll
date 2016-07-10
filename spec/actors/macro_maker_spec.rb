require 'redis'

require 'spec_helper'

require './lib/actors/macro_maker'

describe 'macro_maker' do
  let(:text)               { "def sword-atk 3d6" }
  let(:comment)     { "a comment!" }

  let(:redis_url)       { "redis://example.com" }
  let(:mock_redis)  { double() }

  subject(:parser) { MacroMaker.new(
    text: text,
    comment: comment,
  ) }

  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("REDIS_URL").and_return(redis_url)
  end

  describe '#save' do
    it 'hits redis with the correct values' do
      expect(Redis).to receive(:new).with(url: redis_url).and_return(mock_redis)
      expect(mock_redis).to receive(:set).with("sword-atk", "3d6 # a comment!")

      expect(subject.save).to eq("Macro 'sword-atk' set successfully!")
    end
  end
end
