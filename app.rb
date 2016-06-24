require 'sinatra'

class SlackSlashRoll < Sinatra::Base
  get '/' do
    "Stay awhile, and listen"
  end

  post '/roll' do
    "Rollin', rolling', rollin' haven't slept in weeks"
  end
end
