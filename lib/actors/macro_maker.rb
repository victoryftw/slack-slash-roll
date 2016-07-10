class MacroMaker
  def initialize(text: text_input, comment: comment_input)
    @text = text
    @comment = comment
    @comment_char = TextParser::COMMENT_CHAR
  end

  def save
    @text
  end
end
