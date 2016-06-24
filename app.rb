require 'sinatra'
require './lib/roller'

class SlackSlashRoll < Sinatra::Base
  get '/' do
    "Stay awhile, and listen"
  end

  post '/roll' do
    key = ENV["SLACK_SECRET_KEY"]

    if key != ""
    "Rollin', rolling', rollin' haven't slept in weeks"
    end

    params["channel_id"]

  end
end
