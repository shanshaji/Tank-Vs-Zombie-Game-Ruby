class Cloud < Sprite
	attr_sprite
	def initialize(x:, y:, w: 128, h: 101)
		random_cloud = (1..4).to_a.sample
		path = "sprites/clouds/clouds_#{random_cloud}.png"
        super(x: x, y: y, w: w, h: h, path: path)
		@s    = 0.1 + (0.5.randomize :ratio)
	end

	def move
	    @x += @s
	    @y += @s
	end

	def outside? width, height
		@x >= width || @y >= height
	end

    def draw_override ffi_draw
    # first move then draw
    move

    # The argument order for ffi.draw_sprite is:
    # x, y, w, h, path
    ffi_draw.draw_sprite @x, @y, @w, @h, @path

    # The argument order for ffi_draw.draw_sprite_2 is (pass in nil for default value):
    # x, y, w, h, path,
    # angle, alpha

    # The argument order for ffi_draw.draw_sprite_3 is:
    # x, y, w, h,
    # path,
    # angle,
    # alpha, red_saturation, green_saturation, blue_saturation
    # flip_horizontally, flip_vertically,
    # tile_x, tile_y, tile_w, tile_h
    # angle_anchor_x, angle_anchor_y,
    # source_x, source_y, source_w, source_h
  end
end