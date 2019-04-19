require 'rcomposite'

class CaseGrid
  class Canvas < RComposite::Canvas
    def rotate(angle)
      flatten
      super(-angle.degrees)
      adjust_scale_post_rotation angle
    end

    def flatten
      self.layers = [RComposite::Layer.new(image: render)]
    end

    private

    def adjust_scale_post_rotation(angle)
      scale(*post_rotation_size(angle))
      recenter angle
    end

    def post_rotation_size(angle)
      adjustment = post_rotation_scale_adjustment angle
      [width + adjustment, height + adjustment]
    end

    def recenter(angle)
      offset_amounts = [-0.5 * post_rotation_scale_adjustment(angle)] * 2
      offset(*offset_amounts)
    end

    def post_rotation_scale_adjustment(angle)
      ratio = Math.sin(angle.radians)
      2 * [ratio * width, ratio * height].max
    end
  end
end
