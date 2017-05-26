module MiniD20::Node
  class H2 < Base
    def render
      font :h2
      pdf.text node.inner_html.strip
      pdf.move_down 1
      pdf.stroke { pdf.horizontal_rule }
      pdf.move_down 5
    end
  end
end
