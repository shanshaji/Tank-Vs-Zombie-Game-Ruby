class Room
  def initialize(x, y, w, h)
    @x1 = x
    @y1 = y
    @x2 = x + w
    @y2 = y + h
  end

  def x1
    @x1
  end

  def y1
    @y1
  end

  def x2
    @x2
  end

  def y2
    @y2
  end

  def center
    center_x = (@x1 + @x2) / 2
    center_y = (@y1 + @y2) / 2
    [center_x.to_i, center_y.to_i]
  end

  def intersects_with rect
    (@x1 <= rect.x2) && (@x2 >= rect.x1) && (@y1 <= rect.y2) && (@y2 >= rect.y1)
  end
end
