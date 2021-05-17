class Enemy
	attr_sprite
	attr_accessor :future_position
	def initialize(x:, y:, hp: 2, w:16, h:16)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = 'sprites/square/red.png'
		@hp = hp
		@damage = 0
		@future_position = { dx: FutureObject.new(x, y, w, h), dy: FutureObject.new(x, y, w, h) }
	end


	def attack player
		#move
	  dx =  0
      dx =  1 if @x < player.x
      dx = -1 if @x > player.x
      dy =  0
      dy =  1 if @y < player.y
      dy = -1 if @y > player.y
      future_player_position_new dx, dy
	end

	def future_player_position_new dx, dy
    	new_x = @x + dx
	    new_y = @y + dy 
	    @future_position[:dx].x = new_x
	    @future_position[:dx].y = @y
	    @future_position[:dy].x = @x
	    @future_position[:dy].y = new_y
  	end

  	def intersect_future_position?(others, difference)
		others.find { |o| (o.object_id != self.object_id) && (o.intersect_rect? @future_position[difference]) }
	end

	def attacked_by projectile
		@damage += 1
	end

	def dead?
		@damage > @hp
	end
end