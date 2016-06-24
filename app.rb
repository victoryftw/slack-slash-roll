require 'sinatra'

class SlackSlashRoll < Sinatra::Base
  get '/' do
    "Stay awhile, and listen"
    ENV["SLACK_SECRET_KEY"]
  end

  post '/roll' do
    key = ENV["SLACK_SECRET_KEY"]

    "Rollin', rolling', rollin' haven't slept in weeks"


  end
end
