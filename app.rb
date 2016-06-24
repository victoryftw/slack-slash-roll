require 'sinatra'
require './lib/roller'
require './lib/roll_validator'

class SlackSlashRoll < Sinatra::Base
  get '/' do
    "Stay awhile, and listen"
  end

  post '/roll' do
    key = ENV["SLACK_SECRET_KEY"]

    params

  end
end
