require 'redis'

require './lib/actors/text_parser'

class MacroMaker
  def initialize(text: text_input, comment: comment_input)
    @text = text
    @comment = comment

    @comment_char = TextParser::COMMENT_CHAR
    @redis = Redis.new(:url => ENV["REDIS_URL"])
  end

  def save
    begin
      save_macro(@text)
    rescue => exc
      if exc == false
        return "??? Wat ???"
      else
        return "INVALID MACRO CODE"
      end
    end
  end

  def save_macro(text)
    command_parts = text.partition(" ")
    cmd_def = command_parts.first
    macro = command_parts.last

    macro_parts = macro.partition(" ")
    macro_name = macro_parts.first
    macro_command = macro_parts.last

    @redis.set(macro_name, "#{macro_command} #{@comment_char} #{@comment}")
    "Macro '#{macro_name}' set successfully!"
  end
end
