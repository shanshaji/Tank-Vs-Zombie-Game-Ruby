module CommonHelperMethods
  def to_cell ordinal_x, ordinal_y
    { x: ordinal_x * 16, y: ordinal_y * 16, w: 16, h: 16 }
  end
end