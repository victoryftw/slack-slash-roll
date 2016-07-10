require 'redis'

require './lib/actors/text_parser'
require './lib/actors/roller'

class MacroRoller
  def initialize(text: text_input, comment: comment_input)
    @text = text
    @comment = comment

    @comment_char = TextParser::COMMENT_CHAR
    @redis = Redis.new(:url => ENV["REDIS_URL"])
  end

  def roll
    begin
      roll_macro(@text)
    rescue => exc
      if exc == false
        return "??? Wat ???"
      else
        return "INVALID MACRO CODE"
      end
    end
  end

  def roll_macro(text)
    macro_name = text.strip.split(/\s/).first.strip

    macro = @redis.get(macro_name)

    command_parts = macro.partition(@comment_char)
    command = command_parts.first.strip
    comment = command_parts.last.strip

    Roller.new(text: command, comment: comment).roll
  end
end
