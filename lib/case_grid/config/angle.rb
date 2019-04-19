class CaseGrid
  class Config
    Angle = Struct.new :degrees do
      def radians
        degrees * Math::PI / 180
      end
    end
  end
end
