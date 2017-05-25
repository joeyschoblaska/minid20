module Prawn
  class Document
    def reflow_column_box(*args, &block)
      init_column_box(block) do |parent_box|
        map_to_absolute!(args[0])
        @bounding_box = ReflowColumnBox.new(self, parent_box, *args)
      end
    end

    private

    class ReflowColumnBox < ColumnBox
      def move_past_bottom
        @current_column = (@current_column + 1) % @columns
        @document.y = @y
        if 0 == @current_column
          @y = @parent.absolute_top
          @document.start_new_page
        end
      end
    end
  end
end
