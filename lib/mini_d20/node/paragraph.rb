module MiniD20::Node
  class Paragraph < Base
    def render
      html = MiniD20::Node.clean_html(node.inner_html)
      font :primary
      pdf.text html, inline_format: true
      pdf.move_down 10
    end
  end
end
