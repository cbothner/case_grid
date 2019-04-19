require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

require 'forwardable'
require 'rcomposite'
require 'rmagick'

class CaseGrid
  class Error < StandardError; end

  extend Forwardable

  attr_reader :canvas
  attr_reader :config
  attr_reader :images
  attr_reader :layout

  def_delegators :canvas, :render

  def self.generate(*files)
    new(files).generate
  end

  def initialize(files, config: Config.instance, layout: GridLayout.new)
    @config = config
    @layout = layout
    @canvas = Canvas.new(config.width, config.height)
    @images = files.map { |file| Image.process file }.cycle
  end

  def generate
    overlay_gradient
    create_grid
    rotate
    render
  end

  private

  def create_grid
    layout.each_position do |x, y|
      canvas.layer image: images.next do
        offset x, y
      end
    end
  end

  def rotate
    canvas.rotate(config.angle)
  end

  def overlay_gradient
    canvas.fill_layer RComposite::Gradient, 0, 0, 50, 0, '#999', '#000' do
      mode RComposite::Screen
    end
  end
end
