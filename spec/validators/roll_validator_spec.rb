require 'spec_helper'
require './lib/validators/roll_validator'

describe 'RollValidator' do
  let(:send_token)        { "gIkuvaNzQIHg97ATvDxqgjtO" }
  let(:token)                   { send_token }
  let(:team_id)              { "T0001" }
  let(:team_domain)    { "example" }
  let(:channel_id)         { "C2147483705" }
  let(:channel_name)  { "test" }
  let(:user_id)               { "U2147483697" }
  let(:user_name)        { "Steve" }
  let(:command)           { "/roll" }
  let(:text)                      { "3d6 + 5" }
  let(:response_url)     { "https://hooks.slack.com/commands/1234/5678" }

  let(:params) {   {
    "token" => token,
    "team_id" => team_id,
    "team_domain" => team_domain,
    "channel_id" => channel_id,
    "channel_name" => channel_name,
    "user_id" => user_id,
    "user_name" => user_name,
    "command" => command,
    "text" => text,
    "response_url" => response_url
  } }

  subject(:validator) { RollValidator.new(params) }

  before do
    allow(ENV).to receive(:[]).with("SLACK_SECRET_KEY").and_return(send_token)
  end

  its(:team_id)                     { is_expected.to eq(team_id) }
  its(:team_domain)           { is_expected.to eq(team_domain) }
  its(:channel_id)                { is_expected.to eq(channel_id) }
  its(:channel_name)         { is_expected.to eq(channel_name) }
  its(:user_id)                      { is_expected.to eq(user_id) }
  its(:user_name)               { is_expected.to eq(user_name) }
  its(:command)                 { is_expected.to eq(command) }
  its(:text)                            { is_expected.to eq(text) }
  its(:response_url)           { is_expected.to eq(response_url) }

  describe '#valid?' do
    it 'when the tokens match it returns true ' do
      expect(validator.valid?).to eq(true)
    end

    context "when the tokens don't match" do
      let(:token)                   { "asdfasdfasdf" }

      it 'returns false' do
        expect(validator.valid?).to eq(false)
      end
    end
  end
end
