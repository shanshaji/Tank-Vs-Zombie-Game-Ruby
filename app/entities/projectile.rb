class Projectile
	attr_sprite
	attr_accessor :at, :angle, :collided
	def initialize(tick_count:, angle:, x:, y:)
		@collided = false
		@path = 'sprites/square/blue.png'
		@at = tick_count
        @x = x
        @y = y
        @angle = angle
        @w= 4
        @h= 4                     
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