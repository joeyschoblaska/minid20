module MiniD20::Node
  SUBCLASSES = {
    div: Div,
    h1: H1,
    h2: H2,
    h3: H3,
    p: Paragraph,
    table: Table
  }

  def self.render(node, pdf)
    if subclass = SUBCLASSES[node.name.to_sym]
      subclass.render(node, pdf)
    else
      node.children.each { |c| render(c, pdf) }
    end
  end
end
