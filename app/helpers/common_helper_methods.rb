module CommonHelperMethods

  def to_cell coordinate
  	coordinate * 16
  end
 
  def render_screen x, y, text
    # outputs.labels << { x: x, y: y.from_top, text: text }
    outputs.background_color = [0, 0, 0]
    outputs.labels << { x: x, y: y.from_top, text: text, size_enum: -1, alignment_enum: 1, r: 0, g: 0, b: 0,
                           a: 150 }
    outputs.labels << { x: x, y: y.from_top, text: text, size_enum: -1, alignment_enum: 1, r: 0, g: 200,
                           b: 25 }
  end
end

class Range
  def rnd
    a, b = self.begin, self.end
    a + rand(b - a + 1)
  end
end