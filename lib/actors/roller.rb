require 'dicebag'
require 'dentaku'

require './lib/actors/text_parser'

class Roller
  def initialize(text: text_input, comment: comment_input)
    @text = text
    @comment = comment
    @comment_char = TextParser::COMMENT_CHAR

    @calculator = Dentaku::Calculator.new
  end

  def roll
    if @comment.nil? || @comment == ""
      parse_roll(@text).first
    else
      "#{parse_roll(@text).first} #{@comment_char} #{@comment}"
    end
  end

  def parse_roll(command)
    command = command.dup
    mcommand = mmify(command)

    while mcommand_part = mcommand.scan((/(?=\{((?:[^{}]++|\{\g<1>\})++)\})/)).first
      mcommand_part = mcommand_part.first
      command_part = demmify(mcommand_part)

      command_parts = parse_roll(command_part)
      command_part_string = command_parts.first
      command_part_value = command_parts.last

      mcommand.sub!("{#{mcommand_part}}", command_part_value)
      command.sub!(command_part, command_part_string)
    end

    if value = @calculator.evaluate(mcommand)
      mcommand = value.to_s
      command += " => #{mcommand}"
    end

    if /^-?[0-9]*$/ =~ mcommand
      [command, mcommand]
    else
      roll_dice(mcommand)
    end
  end

  def mmify(text)
    text.gsub('(', '{').gsub(')', '}')
  end

  def demmify(text)
    text.gsub('{', '(').gsub('}', ')')
  end

  def roll_dice(command)
    dice_roll = DiceBag::Roll.new(command)

    dice_roll.result

    sections = dice_roll.tree.map do |roll|
      symbol_string = roll.first
      section_string = case symbol_string
                                   when :start
                                      ""
                                    when :add
                                      " + "
                                    when :sub
                                      " - "
                                    when :div
                                      " / "
                                    when :mul
                                      " * "
                                    end

      die_roll = roll.last

      section_string += "#{die_roll.total}"
      section_string += " (#{die_roll.tally.join(', ')})" if die_roll.is_a?(DiceBag::RollPart)
      section_string
    end

    format_string = sections.join("").strip

    dice_result = dice_roll.result.to_s
    format_string += " => #{dice_result}"

    [format_string, dice_result.delete("{").delete("}")]
  end
end
