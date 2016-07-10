require 'spec_helper'
require './lib/actors/roller'

describe 'roller' do
  let(:comment)     { "a comment!" }

  subject(:parser) { Roller.new(
    text: text,
    comment: comment,
  ) }

  describe '#roll' do
    context 'when its just a number' do
      let(:text) { "1337" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("1337 => 1337 # a comment!")
      end
    end

    context 'when its just a dice code with no number' do
      let(:text) { "d6" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("6 (6) => 6 # a comment!")
      end
    end

    context 'when its just a dice code' do
      let(:text) { "3d6" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("15 (6, 5, 4) => 15 # a comment!")
      end
    end

    context 'when there are no sets of parens' do
      let(:text) { "3d6 - 1" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("15 (6, 5, 4) - 1 => 14 # a comment!")
      end
    end

    context 'when there is one set of parens' do
      let(:text)               { "(3d6 / 2d4) - 5" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("(15 (6, 5, 4) / 5 (4, 1) => 3) - 5 => -2 # a comment!")
      end
    end

    context 'when there are two sets of parens' do
      let(:text) { "((3d6 - 2d4 + 1) * 5)" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("((15 (6, 5, 4) - 5 (4, 1) + 1 => 11) * 5 => 55) => 55 # a comment!")
      end
    end

    context 'when there are three sets of parens' do
      let(:text) { "(((3d6 - 2d4) / 5) + 1) * 3" }

      it 'returns a correct vaue' do
        value = subject.roll

        expect(value).to eq("(((15 (6, 5, 4) - 5 (4, 1) => 10) / 5 => 2) + 1 => 3) * 3 => 9 # a comment!")
      end
    end
  end
end
