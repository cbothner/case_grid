require 'rmagick'

class CaseGrid
  class Image
    attr_reader :config
    attr_reader :raw_image

    def self.process(file)
      raw_image = Magick::Image.read(file).first
      new(raw_image).process
    end

    def initialize(raw_image, config: Config.instance)
      @raw_image = raw_image
      @config = config
    end

    def process
      raw_image.resize_to_fill config.cell_size, config.cell_size
    end
  end
end
