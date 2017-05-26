module MiniD20::Node
  class H1 < Base
    def render
      pdf.font "Book Antiqua", size: 16
      pdf.text node.inner_html.strip, align: :center
      pdf.move_down 20
    end
  end
end
