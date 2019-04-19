RSpec.describe CaseGrid::GridLayout do
  describe '#each_position' do
    it 'yields x, y positions for the top left corners of cells in a grid' do
      c = config(cell_size: 10, cell_gap: 0, height: 20, width: 20)
      layout = described_class.new c

      expect { |b| layout.each_position(&b) }
        .to yield_successive_args(
          [0, 0],
          [10, 0],
          [0, 10],
          [10, 10]
        )
    end

    it 'yields correct positions including a gap' do
      c = config(cell_size: 10, cell_gap: 5, height: 30, width: 30)
      layout = described_class.new c

      expect { |b| layout.each_position(&b) }
        .to yield_successive_args(
          [0, 0],
          [15, 0],
          [0, 15],
          [15, 15]
        )
    end
  end
end
