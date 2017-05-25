module MiniD20::Node
  SUBCLASSES = {
    p: Paragraph
  }

  def self.process(node, pdf)
    if subclass = SUBCLASSES[node.name.to_sym]
      subclass.process(node, pdf)
    end

    node.children.each { |c| process(c, pdf) }
  end
end
