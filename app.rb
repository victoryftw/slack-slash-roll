require 'sinatra'
require './lib/actors/roller'
require './lib/validators/roll_validator'

class SlackSlashRoll < Sinatra::Base
  get '/' do
    "Stay awhile, and listen"
  end

  post '/roll' do
    content_type :json

    # validator = RollValidator.new(params)
    # unless validator.valid?
    #   return "Cheater, cheater!"
    # end

    {
      "response_type": "in_channel",
      "text": "kdflksjdlkfjslkdjflksdjflksjdflksjlkdfj",
    }.to_json
  end
end
