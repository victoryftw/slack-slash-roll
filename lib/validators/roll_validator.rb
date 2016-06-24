class RollValidator
  attr_accessor :team_id, :team_domain, :channel_id, :channel_name, :user_id, :user_name, :command, :text, :response_url

  def initialize(params)
    @key = ENV["SLACK_SECRET_KEY"]

    @token = params["token"]
    @team_id = params["team_id"]
    @team_domain = params["team_domain"]
    @channel_id = params["channel_id"]
    @channel_name = params["channel_name"]
    @user_id = params["user_id"]
    @user_name = params["user_name"]
    @command = params["command"]
    @text = params["text"]
    @response_url = params["response_url"]
  end

  def valid?
    @key == @token
  end
end
