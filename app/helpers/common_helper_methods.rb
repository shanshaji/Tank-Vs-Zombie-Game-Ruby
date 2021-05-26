module CommonHelperMethods

  # def to_cell(ordinal_x, ordinal_y)
  #   { x: ordinal_x * 16, y: ordinal_y * 16, w: 16, h: 16 }
  # end
  def to_cell coordinate
  	coordinate * 16
  end
 #  def intersect_multiple_rect?(others)
	# others.find { |o| (o != self) && (o.intersect_rect? self) }
 #  end
end

class Range
  def rnd
    a, b = self.begin, self.end
    a + rand(b - a + 1)
  end
end