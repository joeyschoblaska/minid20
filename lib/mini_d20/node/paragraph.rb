module MiniD20::Node
  module Paragraph
    def self.process(node, pdf)
      text = node.inner_html.gsub(/\n/, "").gsub(/\s+/, " ")

      pdf.font "Book Antiqua", size: 10
      pdf.text text, inline_format: true
      pdf.move_down 10
    end
  end
end
