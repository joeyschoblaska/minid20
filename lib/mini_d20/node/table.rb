module MiniD20::Node
  class Table < Base
    LIGHT_FILL = "d9d9d9"
    DARK_FILL = "a6a6a6"

    attr_accessor :widths

    def initialize(node, pdf)
      super
      self.widths = []
    end

    def render
      font :primary
      tr_stripe_i = 0

      node.css("tr").each do |tr|
        set_widths(tr)

        bounding_box [bounds.left, cursor], width: bounds.width do
          render_cells(tr) # render once to establish row height

          if tr.css("th").empty?
            render_fills(tr, tr_stripe_i)
            render_cells(tr) # render second time to paint over background fill
            stroke { horizontal_rule } if tr_stripe_i == 0
            tr_stripe_i += 1
          end

          move_cursor_to bounds.bottom
        end
      end

      stroke { horizontal_rule }

      move_down 11
    end

    private

    def render_cells(tr)
      cells(tr).each_with_index do |cell, i|
        move_down 1
        render_cell(cell, i)
        move_cursor_to bounds.top
      end
    end

    def cells(tr)
      tr.css("td, th")
    end

    def render_cell(cell, i)
      html = clean_html(cell.inner_html)
      font cell.name == "th" ? :th : :primary
      align = html_classes(cell).include?("center") ? :center : :left

      bounding_box [cell_left(i, true), cursor], width: cell_width(i, true) do
        text html, inline_format: true, align: align
      end
    end

    def cell_left(i, padded = false)
      left = widths[0, i].reduce(0) { |sum, i| sum + i } / 100.0 * bounds.width
      padded ? left + 1 : left
    end

    def cell_width(i, padded = false)
      width = widths[i] / 100.0 * bounds.width
      padded ? width - 1 : width
    end

    def render_fills(tr, tr_i)
      if html_classes.include?("checkered")
        cells(tr).each_with_index do |cell, i|
          if even?(tr_i) && odd?(i)
            fill_cell(i, DARK_FILL)
          elsif even?(tr_i) || odd?(i)
            fill_cell(i, LIGHT_FILL)
          end
        end
      elsif even?(tr_i)
        fill_row(LIGHT_FILL)
      end
    end

    def fill_cell(i, color)
      fill_color color
      fill { rectangle [cell_left(i), cursor], cell_width(i), bounds.height }
      fill_color "000000"
    end

    def fill_row(color)
      fill_color color
      fill { rectangle [bounds.left, cursor], bounds.width, bounds.height }
      fill_color "000000"
    end

    def even?(n)
      n % 2 == 0
    end

    def odd?(n)
      !even?(n)
    end

    def set_widths(tr)
      cells = tr.css("td, th")

      if cells.all? { |c| c.attr(:width) }
        self.widths = cells.map { |c| c.attr(:width).to_i }
      end
    end
  end
end
