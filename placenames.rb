require 'prawn'
require 'yaml'
require 'prawn/measurement_extensions'

Pathname.new('output').children.each { |p| p.unlink }
names = YAML.load_file('data/guests.yml')

FONT_SIZE = 60
CARD_HEIGHT = 6.96.cm
CARD_WIDTH = 10.24.cm
TEXT_DISTANCE_FROM_BOTTOM_OF_CARD = 1.in

TOP_Y = 700
BOTTOM_Y = 400
LEFT_X = 255
RIGHT_X = 550

names.each_slice(4) do |batch|
  batch_names = batch.map do |name|
    name.split(' ')[0]
  end
  Prawn::Document.generate("output/#{batch_names.join('-')}.pdf", page_size: 'A4', page_layout: :portrait, margin: [0,0,0,0]) do |pdf|
    pdf.font_families.update("MoonFlower" => { normal: 'fonts/Moon Flower.ttf' })
    pdf.font('MoonFlower')
    pdf.stroke_color "000000"
    # Top left
    name_y = (TOP_Y - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = LEFT_X + (-20 * batch_names[0].length - 1)
    pdf.draw_text batch_names[0], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [2, TOP_Y], CARD_WIDTH, CARD_HEIGHT
    end

    # Top right
    name_y = (TOP_Y - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = RIGHT_X + (-20 * batch_names[1].length - 1)
    pdf.draw_text batch_names[1], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [300, TOP_Y], CARD_WIDTH, CARD_HEIGHT
    end

    # Bottom left
    name_y = (BOTTOM_Y - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = LEFT_X + (-20 * batch_names[2].length - 1)
    pdf.draw_text batch_names[2], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [2, BOTTOM_Y], CARD_WIDTH, CARD_HEIGHT
    end

    # Bottom right
    name_y = (BOTTOM_Y - CARD_HEIGHT) + TEXT_DISTANCE_FROM_BOTTOM_OF_CARD
    name_x = RIGHT_X + (-20 * batch_names[3].length - 1)
    pdf.draw_text batch_names[3], at: [name_x, name_y], size: FONT_SIZE
    pdf.stroke do
      pdf.rectangle [300, BOTTOM_Y], CARD_WIDTH, CARD_HEIGHT
    end

  end
end
