require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

require 'rcomposite'
require 'forwardable'

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
    @canvas = RComposite::Canvas.new(config.width, config.height)
    @images = files.map { |file| Image.process file }.cycle
  end

  def generate
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
    flatten
    canvas.rotate(-config.angle.degrees)
    adjust_scale_post_rotation
  end

  def flatten
    canvas.layers = [RComposite::Layer.new(image: canvas.render)]
  end

  def adjust_scale_post_rotation
    canvas.scale(*post_rotation_size)
    recenter
  end

  def post_rotation_size
    adjustment = post_rotation_scale_adjustment
    [config.width + adjustment, config.height + adjustment]
  end

  def recenter
    offset = [-0.5 * post_rotation_scale_adjustment] * 2
    canvas.offset(*offset)
  end

  def post_rotation_scale_adjustment
    ratio = Math.sin(config.angle.radians)
    2 * [ratio * config.width, ratio * config.height].max
  end
end
