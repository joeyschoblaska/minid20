module MiniD20::Node
  class Table
    attr_accessor :widths, :stripe, :pdf, :node

    def self.render(node, pdf)
      new(node, pdf).render
    end

    def initialize(node, pdf)
      self.widths = []
      self.stripe = :dark
      self.node = node
      self.pdf = pdf
    end

    def render
      set_widths

      node.css("tr").each do |tr|
        pdf.bounding_box [pdf.bounds.left, pdf.cursor], width: pdf.bounds.width, height: 11 do
          tr.css("td").each_with_index do |td, i|
            render_td(td, i)
            pdf.move_cursor_to pdf.bounds.top
          end
        end

        if html_classes(tr).include?("underline")
          pdf.stroke { pdf.horizontal_rule }
        end

        pdf.move_down 3
      end
    end

    private

    def render_td(td, i)
      html = MiniD20::Node.clean_html(td.inner_html)
      pdf.font "Book Antiqua", size: 10

      tr_width = pdf.bounds.width
      td_left = widths[0, i].reduce(0) { |sum, i| sum + i } / 100.0 * tr_width
      td_width = widths[i] / 100.0 * tr_width

      pdf.bounding_box [td_left, pdf.cursor], width: td_width, height: pdf.bounds.height do
        pdf.text html, inline_format: true
      end
    end

    def set_widths
      tds = node.css("tr").first.css("td")
      self.widths = tds.map { |td| td.attr(:width).to_i }
    end

    def html_classes(element)
      (element.attr(:class) || "").split(" ")
    end
  end
end
