module MiniD20::Node
  class Table < Base
    attr_accessor :widths, :stripes, :top_line_drawn

    def initialize(node, pdf)
      super
      self.widths = []
      self.stripes = [:dark, :light]
      self.top_line_drawn = false
    end

    def render
      font :primary

      node.css("tr").each do |tr|
        set_widths(tr)

        if tr.css("th").empty? && !top_line_drawn
          stroke { horizontal_rule }
          self.top_line_drawn = true
        end

        bounding_box [bounds.left, cursor], width: bounds.width do
          render_cells(tr) # render once to determine row height
          render_tr_fill(tr)
          render_cells(tr) # render second time to paint over background fill

          move_cursor_to bounds.bottom
        end
      end

      stroke { horizontal_rule }

      move_down 10
    end

    private

    def render_cells(tr)
      tr.css("td, th").each_with_index do |cell, i|
        move_down 1
        render_cell(cell, i)
        move_cursor_to bounds.top
      end
    end

    def render_cell(cell, i)
      html = clean_html(cell.inner_html)
      font cell.name == "th" ? :th : :primary

      tr_width = bounds.width
      cell_left = widths[0, i].reduce(0) { |sum, i| sum + i } / 100.0 * tr_width
      cell_width = widths[i] / 100.0 * tr_width
      align = html_classes(cell).include?("center") ? :center : :left

      if i == 0
        cell_left += 1
        cell_width -= 1
      end

      bounding_box [cell_left, cursor], width: cell_width do
        text html, inline_format: true, align: align
      end
    end

    def render_tr_fill(tr)
      if tr.css("th").empty? && self.stripes.reverse!.first == :dark
        fill_color "cccccc"
        fill { rectangle [bounds.left, cursor], bounds.width, bounds.height }
        fill_color "000000"
      end
    end

    def set_widths(tr)
      cells = tr.css("td, th")

      if cells.all? { |c| c.attr(:width) }
        self.widths = cells.map { |c| c.attr(:width).to_i }
      end
    end
  end
end
