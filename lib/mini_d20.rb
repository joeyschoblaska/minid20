class MiniD20
  def self.process(file)
    input = File.read("src/#{file}.html")
    doc = Nokogiri::HTML(input)

    Prawn::Document.generate("doc/#{file}.pdf") do |pdf|
      doc.children.each { |c| element(c, pdf) }
    end
  end

  def self.element(node, pdf)
    case node.name.to_sym
    when :p
      pdf.text node.text
    end

    node.children.each { |c| element(c, pdf) }
  end
end
