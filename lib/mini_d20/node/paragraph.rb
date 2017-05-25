module MiniD20::Node
  module Paragraph
    def self.process(node, pdf)
      pdf.font "Book Antiqua", size: 10
      pdf.text node.inner_html.strip, inline_format: true
      pdf.move_down 10
    end
  end
end
