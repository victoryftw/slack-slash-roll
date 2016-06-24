require 'dicebag'

class Roller
  def initialize(text: text_input)
    @text = text
  end

  def roll
    dice_roll = DiceBag::Roll.new(@text)

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
    format_string += " => #{dice_roll.result.to_s}"
  end
end
