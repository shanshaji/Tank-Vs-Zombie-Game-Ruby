class Projectile < AnimatedSprite
	attr_sprite
	attr_accessor :at, :angle, :collided, :power
	def initialize(tick_count:, angle:, x:, y:, w: 4, h: 4)
		path = 'sprites/square/blue.png'
		super(x: x, y: y, w: w, h: h, path: path, no_of_sprites: 0)
		@collided = false
		@at = tick_count
        @angle = angle
        @power = 2                 
	end

	def move
	  dx, dy = @angle.vector 10
      @x += dx
      @y += dy
	end

	def is_not_active?
		@collided || @at.elapsed_time > 10000
	end

	def calc_projectile_collisions entities
	    entities.each do |e|
	      if !@collided && (intersect_rect? e)
	      	@collided = true
	      	e.attacked_by(self)
	      end
    	end
	end
end