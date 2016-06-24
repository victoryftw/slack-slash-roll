require 'sinatra'
require 'json'
require './lib/actors/text_parser'
require './lib/validators/roll_validator'

module Rolling
  class SlackSlashRoll < Sinatra::Base
    get '/' do
      "Stay awhile, and listen"
    end

    post '/roll' do
      content_type :json

      validator = RollValidator.new(params)
      unless validator.valid?
        return "Cheater, cheater!"
      end

      parser = TextParser.new(
        player: validator.user_name,
        command: validator.command,
        text: validator.text
      )

      text = parser.process

      {
        "response_type": "in_channel",
        "text": "#{text}",
      }.to_json
    end
  end
end
