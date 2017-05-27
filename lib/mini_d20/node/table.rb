module MiniD20::Node
  class Table < Base
    attr_accessor :widths, :stripes, :top_line_drawn

    TR_HEIGHT = 11
    TR_V_PAD = 2

    def initialize(node, pdf)
      super
      self.widths = []
      self.stripes = [:dark, :light]
      self.top_line_drawn = false
    end

    def render
      font :primary
      set_widths

      node.css("tr").each do |tr|
        if tr.css("th").empty? && self.stripes.reverse!.first == :dark
          fill_color "cccccc"
          fill { rectangle [bounds.left, cursor], bounds.width, TR_HEIGHT }
          fill_color "000000"
        end

        if tr.css("th").empty? && !top_line_drawn
          stroke { horizontal_rule }
          self.top_line_drawn = true
        end

        bounding_box [bounds.left, cursor], width: bounds.width, height: TR_HEIGHT do
          tr.css("td, th").each_with_index do |cell, i|
            move_down TR_V_PAD
            render_cell(cell, i)
            move_cursor_to bounds.top
          end
        end
      end

      stroke { horizontal_rule }

      move_down 10
    end

    private

    def render_cell(cell, i)
      html = MiniD20::Node.clean_html(cell.inner_html)
      font cell.name == "th" ? :th : :primary

      tr_width = bounds.width
      cell_left = widths[0, i].reduce(0) { |sum, i| sum + i } / 100.0 * tr_width
      cell_width = widths[i] / 100.0 * tr_width

      bounding_box [cell_left, cursor], width: cell_width, height: bounds.height do
        text html, inline_format: true
      end
    end

    def set_widths
      tds = node.css("tr").first.css("td, th")
      self.widths = tds.map { |td| td.attr(:width).to_i }
    end
  end
end
