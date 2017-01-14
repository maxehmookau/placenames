require 'prawn'
require 'yaml'
require 'prawn/measurement_extensions'

Pathname.new('output').children.each { |p| p.unlink }
names = YAML.load_file('data/guests.yml')

names.each_slice(4) do |batch|

  Prawn::Document.generate("output/#{batch.join('-')}.pdf", page_size: 'A4', page_layout: :portrait, margin: [0,0,0,0]) do |pdf|

    # Top left
    pdf.font_families.update("MoonFlower" => { normal: 'fonts/Moon Flower.ttf' })
    pdf.stroke_axis
    pdf.font('MoonFlower')
    pdf.draw_text batch[0], at: [200, 475], size: 60
    pdf.stroke do
      pdf.horizontal_line 2, (2 + 10.24.cm), at: 700 - (8.96.cm / 2)
      pdf.rectangle [2, 700], 10.24.cm, 8.96.cm
    end

    # Top right
    pdf.font_families.update("MoonFlower" => { normal: 'fonts/Moon Flower.ttf' })
    pdf.stroke_axis
    pdf.font('MoonFlower')
    pdf.draw_text batch[1], at: [475, 475], size: 60
    pdf.stroke do
      pdf.horizontal_line 300, (300 + 10.24.cm), at: 700 - (8.96.cm / 2)
      pdf.rectangle [300, 700], 10.24.cm, 8.96.cm
    end

    # Bottom left
    pdf.font_families.update("MoonFlower" => { normal: 'fonts/Moon Flower.ttf' })
    pdf.stroke_axis
    pdf.font('MoonFlower')
    pdf.draw_text batch[2], at: [200, 170], size: 60
    pdf.stroke do
      pdf.horizontal_line 2, (2 + 10.24.cm), at: 400 - (8.96.cm / 2)
      pdf.rectangle [2, 400], 10.24.cm, 8.96.cm
    end

    # Bottom right
    pdf.font_families.update("MoonFlower" => { normal: 'fonts/Moon Flower.ttf' })
    pdf.stroke_axis
    pdf.font('MoonFlower')
    pdf.draw_text batch[3], at: [475, 170], size: 60
    pdf.stroke do
      pdf.horizontal_line 300, (300 + 10.24.cm), at: 400 - (8.96.cm / 2)
      pdf.rectangle [300, 400], 10.24.cm, 8.96.cm
    end

  end
end
