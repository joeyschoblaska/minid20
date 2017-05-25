module MiniD20::Node
  module Paragraph
    def self.process(node, pdf)
      pdf.text node.inner_html.strip, inline_format: true
      pdf.move_down 10
    end
  end
end
