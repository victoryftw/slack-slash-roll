require 'sinatra'
require './lib/actors/roller'
require './lib/validators/roll_validator'

class SlackSlashRoll < Sinatra::Base
  get '/' do
    "Stay awhile, and listen"
  end

  post '/roll' do
    key = ENV["SLACK_SECRET_KEY"]

    params

  end
end
