class AnimatedSprite < Sprite
  def initialize(x:,y:, w:, h:, path:, no_of_sprites: , start_looping_at: 0, number_of_frames_to_show_each_sprite: 4, does_sprite_loop: true)
    super(x: x, y: y, w: w, h: h, path: path)
    @angle = 0
    @no_of_sprites = no_of_sprites
    @start_looping_at = start_looping_at
    @number_of_frames_to_show_each_sprite = number_of_frames_to_show_each_sprite
    @does_sprite_loop = does_sprite_loop
  end


  def look_at target
    if @x < target.x
      @flip_horizontally = false
    else
      @flip_horizontally = true
    end
  end


  def running
    @path = "#{absolute_file_name[0..-4] + sprite_index.to_s.rjust(3, "0")}.png"
  end


  private

  def sprite_index
    @start_looping_at.frame_index @no_of_sprites,
                                              @number_of_frames_to_show_each_sprite,
                                              @does_sprite_loop
  end

  def absolute_file_name
    @path.split(".")[0]
  end

end