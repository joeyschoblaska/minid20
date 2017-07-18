module MiniD20::Node
  class Image < Base
    def render
      options = {
        position: html_classes.include?("center") ? :center : :left,
        height: node.attr(:height).to_f
      }

      image path, options
      move_down 15
    end

    def path
      "src/#{node.attr(:src)}"
    end
  end
end
