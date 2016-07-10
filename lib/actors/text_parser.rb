require './lib/actors/macro_maker'
require './lib/actors/macro_roller'
require './lib/actors/roller'

class TextParser

  COMMENT_CHAR = "#"

  def initialize(player: player_input, command: command_input, text: text_input)
    @player = player
    @command = command
    @text = text
  end

  def process
    command_parts = @text.partition(COMMENT_CHAR)
    command = command_parts.first.strip
    comment = command_parts.last.strip

    text_parts = command.split(" ")

    if text_parts.first.include?("def")
      MacroMaker.new(text: command, comment: comment).save
    elsif text_parts.first.match(/^[A-Za-z]/)
      MacroRoller.new(text: command, comment: comment).roll
    else
      Roller.new(text: command, comment: comment).roll
    end
  end
end
