module MiniD20::Node
  class Paragraph < Base
    def render
      html = clean_html(node.inner_html)
      align = html_classes.include?("center") ? :center : :left
      font :primary
      text html, inline_format: true, align: align
      move_down 10
    end
  end
end
