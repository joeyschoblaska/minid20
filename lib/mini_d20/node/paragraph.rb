module MiniD20::Node
  module Paragraph
    def self.process(node, pdf)
      pdf.text node.inner_html, inline_format: true
    end
  end
end
