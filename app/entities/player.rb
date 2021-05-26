class Player < AnimatedSprite
	attr_sprite
	attr_accessor :attacked_at, :projectiles, :angle, :hp, :x, :y, :speed
	def initialize(x: 640, y: 360, w: 50, h: 50)
		path = 'sprites/heroes/tank.png'
		super(x: x, y: y, w: w, h: h, path: path, angle: 0, no_of_sprites: 8, start_looping_at: 1)
	    @attacked_at  = -1
	    @projectiles  = []
	    @hp = 100
	    @speed = 3
	end

	def animate tick_count
		if @attacked_at == tick_count
	     @projectiles << Projectile.new(tick_count: tick_count, x: @x, y: @y, angle: @angle)
	    end
	end

	def move?
		@attacked_at.elapsed_time > 5
	end


  	def future dx, dy
    	new_x = @x + dx
	    new_y = @y + dy 
	    @future_object.x = new_x
	    @future_object.y = new_y
  	end

  	def move_to_future_position
  		@x = @future_object.x
        @y = @future_object.y
  	end

  	def calc_projectiles
  		@projectiles.each do |projectile|
	      projectile.move
	      projectile.calc_projectile_collisions Level.walls + Level.enemies + Level.spawn_locations
	    end
	    @projectiles.delete_if { |p| p.is_not_active? }
	end
end
