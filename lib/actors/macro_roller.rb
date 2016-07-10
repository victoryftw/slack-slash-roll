require 'redis'

require './lib/actors/text_parser'

class MacroRoller
  def initialize(text: text_input, comment: comment_input)
    @text = text
    @comment = comment

    @comment_char = TextParser::COMMENT_CHAR
    @redis = Redis.new(:url => ENV["REDIS_URL"])
  end

  def roll
    @text
  end
end
