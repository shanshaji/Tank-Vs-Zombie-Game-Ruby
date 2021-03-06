class Projectile < AnimatedSprite
	attr_sprite
	attr_accessor :at, :angle, :collided, :power
	def initialize(tick_count:, angle:, x:, y:, w: 15, h: 60, path: 'sprites/missile/Missile_3_Flying_000.png', power: 2)
		super(x: x + 20, y: y, w: w, h: h, path: path, no_of_sprites: 9)
		@collided = false
		@at = tick_count
		@parent_angle = angle
        @angle = angle - 90
        @power = power
        @collission_time = nil                
	end

	def move
	  dx, dy = @parent_angle.vector 10
      @x += dx
      @y += dy
      running
	end

	def is_not_active?
		(@collided && @collission_time.elapsed_time > 3) || @at.elapsed_time > 10000
	end

	def calc_projectile_collisions entities
	    entities.each do |e|
	      if !@collided && (intersect_rect? e)
	      	explode_missile
	      	@collided = true
	      	@collission_time = $game.args.state.tick_count
	      	e.attacked_by(self)
	      end
    	end
	end

	private

	def explode_missile
		file_name_parts = absolute_file_name.split("_")
		file_name_parts[2] = "Explosion"
		new_file_name = file_name_parts.join("_")
		@path = "#{new_file_name}.png"
		@no_of_sprites = 8
  	end
end


