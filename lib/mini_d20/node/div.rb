module MiniD20::Node
  class Div < Base
    def render
      bounds.move_past_bottom if html_classes.include?("page-break")
    end
  end
end
