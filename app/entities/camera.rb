class Camera
	attr_accessor :w, :h, :x, :y, :path
	def initialize(w:, h:, x: 0, y: 0)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = :camera
	end


	def camera_position(player)
	    center_offset_x = 640 - player.x
	    center_offset_y = 360 - player.y
	    center_offset_x = center_offset_x.clamp(-1920, 0)
	    center_offset_y = center_offset_y.clamp(-2480, 0)
	    @x = center_offset_x
	    @y = center_offset_y
	end
end