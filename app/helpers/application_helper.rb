module ApplicationHelper

  def kramdown(text)
    require 'kramdown'
    return Kramdown::Document.new(text, {coderay_line_numbers: nil}).to_html
  end

end
