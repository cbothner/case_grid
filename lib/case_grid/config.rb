require 'singleton'

class CaseGrid
  def self.config
    yield Config.instance
  end

  class Config
    include Singleton

    attr_writer :angle
    attr_accessor :cell_size
    attr_accessor :cell_gap
    attr_accessor :height
    attr_accessor :width

    def initialize
      @angle = 10
      @cell_size = 300
      @cell_gap = 30
      @height = 1200
      @width = 1200
    end

    def angle
      Angle.new @angle
    end
  end
end
