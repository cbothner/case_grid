require 'rmagick'

RSpec.describe CaseGrid::Image do
  let :file do
    File.open 'spec/fixtures/files/wolf.jpeg'
  end

  describe '#process' do
    it 'crops and resizes the image' do
      raw_image = Magick::Image.read(file).first
      image = CaseGrid::Image.new raw_image, config: config(cell_size: 100)

      processed = image.process

      expect(processed.columns).to eq processed.rows
      expect(processed.columns).to eq 100
    end
  end
end
