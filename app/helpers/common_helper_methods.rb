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

   def camera_position
    center_offset_x = 640 - state.player.x
    center_offset_y = 360 - state.player.y
    center_offset_x = center_offset_x.clamp(-1920, 0)
    center_offset_y = center_offset_y.clamp(-2480, 0)
    { x: center_offset_x, y: center_offset_y }
  end
end