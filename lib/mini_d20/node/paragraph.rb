module MiniD20::Node
  module Paragraph
    def self.render(node, pdf)
      html = MiniD20::Node.clean_html(node.inner_html)
      pdf.font "Book Antiqua", size: 10
      pdf.text html, inline_format: true
      pdf.move_down 10
    end
  end
end
