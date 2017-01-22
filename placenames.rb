require 'prawn'
require 'yaml'
require 'prawn/measurement_extensions'

Pathname.new('output').children.each { |p| p.unlink }
names = YAML.load_file('data/guests.yml')

FONT_SIZE = 60
CARD_HEIGHT = 7.96.cm
CARD_WIDTH = 10.24.cm
TEXT_DISTANCE_FROM_BOTTOM_OF_CARD = 0.85.in

names.each_slice(4) do |batch|
  batch_names = batch.map do |name|
    name.split(' ')[0]
  end
  Prawn::Document.generate("output/#{batch_names.join('-')}.pdf", page_size: 'A4', page_layout: :portrait, margin: [0,0,0,0]) do |pdf|
    pdf.font_families.update("MoonFlower" => { normal: 'fonts/Moon Flower.ttf' })
    pdf.font('MoonFlower')
    pdf.stroke_color "000000"
    # Top left
    name_y = (700 - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = 255 + (-20 * batch_names[0].length - 1)
    pdf.draw_text batch_names[0], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [2, 700], CARD_WIDTH, CARD_HEIGHT
    end

    # Top right
    name_y = (700 - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = 550 + (-20 * batch_names[1].length - 1)
    pdf.draw_text batch_names[1], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [300, 700], CARD_WIDTH, CARD_HEIGHT
    end

    # Bottom left
    name_y = (400 - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = 255 + (-20 * batch_names[2].length - 1)
    pdf.draw_text batch_names[2], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [2, 400], CARD_WIDTH, CARD_HEIGHT
    end

    # Bottom right
    name_y = (400 - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = 550 + (-20 * batch_names[3].length - 1)
    pdf.draw_text batch_names[3], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [300, 400], CARD_WIDTH, CARD_HEIGHT
    end

  end
end
