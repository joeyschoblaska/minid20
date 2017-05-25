module MiniD20::Node
  module H1
    def self.render(node, pdf)
      pdf.font "Book Antiqua", size: 16
      pdf.text node.inner_html.strip, align: :center
      pdf.move_down 20
    end
  end
end
