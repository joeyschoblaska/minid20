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
      node.css("tr").each do |tr|
        tr.css("td").each { |td| render_td(td) }
        pdf.stroke { pdf.horizontal_rule }
      end
    end

    def render_td(td)
      html = MiniD20::Node.clean_html(td.inner_html)
      pdf.font "Book Antiqua", size: 10
      pdf.text html, inline_format: true
    end
  end
end
