module MiniD20::Node
  module Paragraph
    def self.process(node, pdf)
      pdf.text node.text
    end
  end
end
