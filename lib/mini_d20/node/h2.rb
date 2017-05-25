module MiniD20::Node
  module H2
    def self.process(node, pdf)
      pdf.font "Book Antiqua", size: 12
      pdf.text node.inner_html.strip, style: :bold
      pdf.stroke { pdf.horizontal_rule }
      pdf.move_down 10
    end
  end
end
