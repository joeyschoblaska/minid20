module MiniD20::Node
  class H3 < Base
    def render
      font :h2
      text node.inner_html.strip
      move_down 1
    end
  end
end
