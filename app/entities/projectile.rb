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
end