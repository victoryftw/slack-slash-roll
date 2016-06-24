require "./app.rb"
require 'spec_helper'
require 'rspec'
require 'rack/test'
require 'json'

include Rack::Test::Methods

def app
  Rolling::SlackSlashRoll.new
end

describe 'app' do
  describe '/' do
    it 'should work' do
      get "/"

      expect(last_response).to be_ok
      expect(last_response.body).to eq("Stay awhile, and listen")
    end
  end

  describe '/roll' do
    let(:send_token)        { "gIkuvaNzQIHg97ATvDxqgjtO" }
    let(:token)                   { send_token }
    let(:text)                      { "3d6 + 5" }
    let(:headers)              { {"Content-Type" => "application/json"} }
    let(:request_data) {   {
        token: token,
        team_id: "T0001",
        team_domain: "example",
        channel_id: "C2147483705",
        channel_name: "test",
        user_id: "U2147483697",
        user_name: "Steve",
        command: "/roll",
        text: text,
        response_url: "https://hooks.slack.com/commands/1234/5678"
      } }

    before do
      allow(ENV).to receive(:[]).with("SLACK_SECRET_KEY").and_return(send_token)
    end

    it 'takes text' do
      post "/roll", request_data, headers

      expect(last_response).to be_ok
      body = JSON.parse(last_response.body)

      expect(body).to eq({"response_type"=>"in_channel", "text"=>"15 (6, 5, 4) + 5 => 20"})
    end

    context 'when the token is invalid' do
      let(:token)  { "dfaskdjfasjd" }
      let(:text)     { "askdjflaskjd" }

      it 'fails' do
        post "/roll", request_data, headers

        expect(last_response).to be_ok
        expect(last_response.body).to eq("Cheater, cheater!")
      end
    end
  end
end
