module MiniD20::Node
  class Table < Base
    attr_accessor :widths, :stripes

    TR_HEIGHT = 11
    TR_V_PAD = 2

    def initialize(node, pdf)
      super
      self.widths = []
      self.stripes = [:dark, :light]
    end

    def render
      font :primary
      set_widths
      pdf.line_width(0.5)

      pdf.stroke { pdf.horizontal_rule }

      node.css("tr").each do |tr|
        if !html_classes(tr).include?("no-stripe") && self.stripes.reverse!.first == :dark
          pdf.fill_color "cccccc"
          pdf.fill { pdf.rectangle [pdf.bounds.left, pdf.cursor], pdf.bounds.width, TR_HEIGHT }
          pdf.fill_color "000000"
        end

        pdf.bounding_box [pdf.bounds.left, pdf.cursor], width: pdf.bounds.width, height: TR_HEIGHT do
          tr.css("td").each_with_index do |td, i|
            pdf.move_down TR_V_PAD
            render_td(td, i)
            pdf.move_cursor_to pdf.bounds.top
          end
        end

        pdf.stroke { pdf.horizontal_rule } if html_classes(tr).include?("underline")
      end

      pdf.stroke { pdf.horizontal_rule }

      pdf.move_down 10
    end

    private

    def render_td(td, i)
      html = MiniD20::Node.clean_html(td.inner_html)

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
  end
end
