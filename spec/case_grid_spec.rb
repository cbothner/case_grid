require 'rmagick'

FILENAMES = [
  'dioxane.jpg',
  'indonesia.jpg',
  'rain-gardens.jpeg',
  'reed.jpg',
  'urban-farming.jpg',
  'wolf.jpeg'
].freeze

RSpec.describe CaseGrid do
  let :files do
    FILENAMES.map do |filename|
      File.open "spec/fixtures/files/#{filename}"
    end
  end

  it 'has a version number' do
    expect(CaseGrid::VERSION).not_to be nil
  end

  it 'generates an image' do
    image = CaseGrid.generate *files
    expect(image).to be_a Magick::Image

    image.write 'example.jpg'
  end
end
