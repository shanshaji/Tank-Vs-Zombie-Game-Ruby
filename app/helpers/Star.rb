class Star
  attr_sprite

  def initialize width, height
    @width = width
    @height = height
    @x = (rand width) * -1
    @y = (rand height) * -1
    @w    = 20
    @h    = 20
    @s    = 1 + (4.randomize :ratio)
    @path = "sprites/misc/tiny-star.png"
  end

  def move
    @x += @s
    @y += @s
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