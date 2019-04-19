require 'forwardable'

class CaseGrid
  class GridLayout
    extend Forwardable

    attr_reader :config
    attr_accessor :x, :y

    def initialize(config = Config.instance)
      @config = config

      @x = 0
      @y = 0
    end

    def each_position
      until outside_viewport?
        yield x, y

        next_column
      end
    end

    private

    def_delegators :config, :cell_size, :cell_gap, :width, :height

    def outside_viewport?
      x >= width || y >= height
    end

    def next_column
      self.x += offset
      next_row if outside_viewport?
    end

    def next_row
      self.x = 0
      self.y += offset
    end

    def offset
      cell_size + cell_gap
    end
  end
end
