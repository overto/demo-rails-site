module PuzzlesHelper

  def display_words(words)
    format_words = words.gsub(/\n/, "<br>")
    return "<p>" + format_words + "</p>"
  end


end
