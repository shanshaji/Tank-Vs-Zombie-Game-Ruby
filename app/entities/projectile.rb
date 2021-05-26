class Projectile < AnimatedSprite
	attr_sprite
	attr_accessor :at, :angle, :collided, :power
	def initialize(tick_count:, angle:, x:, y:, w: 15, h: 60)
		path = 'sprites/missile/Missile_3_Flying_000.png'
		super(x: x + 20, y: y, w: w, h: h, path: path, no_of_sprites: 9)
		@collided = false
		@at = tick_count
		@parent_angle = angle
        @angle = angle - 90
        @power = 2                 
	end

	def move
	  dx, dy = @parent_angle.vector 10
      @x += dx
      @y += dy
      running
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