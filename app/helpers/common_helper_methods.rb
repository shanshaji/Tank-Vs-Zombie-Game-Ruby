module CommonHelperMethods
  def to_cell(ordinal_x, ordinal_y)
    { x: ordinal_x * 16, y: ordinal_y * 16, w: 16, h: 16 }
  end
  def wall_to_cell coordinate
  	coordinate * 16
    # { x: ordinal_x * 16, y: ordinal_y * 16, w: 16, h: 16 }
  end
end