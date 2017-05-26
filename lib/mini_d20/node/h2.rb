module MiniD20::Node
  class H2 < Base
    def render
      pdf.font "Book Antiqua", size: 11
      pdf.text node.inner_html.strip, style: :bold
      pdf.move_down 1
      pdf.stroke { pdf.horizontal_rule }
      pdf.move_down 5
    end
  end
end
