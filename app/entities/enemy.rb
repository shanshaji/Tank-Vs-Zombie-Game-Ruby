class Enemy < AnimatedSprite
	attr_sprite

	MIN_POWER ||= 0.5
	MAX_POWER ||= 5
	MIN_HP ||= 2
	MAX_HP ||= 10
	MIN_SPEED ||= 0.5
	MAX_SPEED ||= 2

	def initialize(x:, y:, hp: 2, w: 30, h: 30, power: 0.5, speed: 1, path: 'sprites/enemy/zombie/zombie_000.png')
		super(x: x, y: y, w: w, h: h, no_of_sprites: 5, path: path)
		@hp = hp
		@power = power
		@speed = speed
	end


	def animate player, others
	  look_at player
	  move_towards player, others
      running
      player.hp -= @power if intersect_rect? player
	end


	def attacked_by projectile
		@hp -= projectile.power
	end

	def dead?
		@hp < 0
	end

	private

	def move_towards target, others
	    #determine path
	    dx =  0
	    dx =  1 if @x < target.x
	    dx = -1 if @x > target.x
	    dy =  0
	    dy =  1 if @y < target.y
	    dy = -1 if @y > target.y
	    determine_future_position dx, dy, others
	end

    def determine_future_position dx, dy, others
      dx *= @speed
      dy *= @speed 
      new_x = @x + dx
      new_y = @y + dy

      @future_object.x = new_x
      @future_object.y = y
      @x = new_x unless @future_object.intersect_multiple_rect? others

      @future_object.x = @x
      @future_object.y = new_y
      @y = new_y unless @future_object.intersect_multiple_rect? others
    end

end