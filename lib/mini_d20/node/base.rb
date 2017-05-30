module MiniD20::Node
  class Base
    attr_accessor :node, :pdf

    FONTS = {
      h1:      ["Book Antiqua", size: 16],
      h2:      ["Book Antiqua", size: 11, style: :bold],
      primary: ["Book Antiqua", size: 9],
      th: ["Book Antiqua", size: 9, style: :bold]
    }

    def self.render(node, pdf)
      new(node, pdf).render
    end

    def method_missing(method, *args, &block)
      pdf.send(method, *args, &block)
    end

    def initialize(node, pdf)
      self.node = node
      self.pdf = pdf
    end

    def html_classes(element)
      (element.attr(:class) || "").split(" ")
    end

    def font(name)
      pdf.font *FONTS[name]
    end

    def clean_html(html)
      html.gsub(/\n/, "").gsub(/\s+/, " ")
    end
  end
end
