class MiniD20::Renderer
  attr_accessor :filename

  def initialize(filename)
    self.filename = filename
  end

  def render

    Prawn::Document.generate(pdf_path) do |pdf|
      pdf.font_families["Book Antiqua"] = {
        normal: { file: "fonts/BookAntiqua.ttf" },
        bold:   { file: "fonts/BookAntiqua-Bold.ttf" }
      }

      pdf.reflow_column_box [0, pdf.cursor], columns: 2, width: pdf.bounds.width do
        doc.children.each { |c| MiniD20::Node.render(c, pdf) }
      end
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
