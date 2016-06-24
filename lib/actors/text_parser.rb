require './lib/actors/macro_maker'
require './lib/actors/roller'

class TextParser
  def initialize(player: player_input, command: command_input, text: text_input)
    @player = player
    @command = command
    @text = text
  end

  def process
    text_parts = @text.split(" ")

    # Handle Comments

    if text_parts.first.include?("def")
      MacroMaker.new(text: @text).save
    elsif text_parts.first.match(/^[A-Za-z]/)
      MacroRoller.new(text: @text).roll
    else
      Roller.new(text: @text).roll
    end
  end
end
