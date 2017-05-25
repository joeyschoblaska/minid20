class MiniD20::Processor
  attr_accessor :filename

  def initialize(filename)
    self.filename = filename
  end

  def process
    Prawn::Document.generate(pdf_path) do |pdf|
      doc.children.each { |c| MiniD20::Node.process(c, pdf) }
    end
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(File.read("src/#{filename}"))
  end

  def pdf_path
    "doc/#{filename.gsub(/\.\w+/, ".pdf")}"
  end
end
