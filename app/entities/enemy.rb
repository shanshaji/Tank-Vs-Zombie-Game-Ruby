class Enemy
	attr_sprite
	attr_accessor :future_position
	def initialize(x:, y:, hp: 2, w:16, h:16, power: 0.5)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = 'sprites/square/red.png'
		@hp = hp
		@power = power
		@future_position = { dx: FutureObject.new(x, y, w, h), dy: FutureObject.new(x, y, w, h) }
	end


	def attack player, others
		#move
	  dx =  0
      dx =  1 if @x < player.x
      dx = -1 if @x > player.x
      dy =  0
      dy =  1 if @y < player.y
      dy = -1 if @y > player.y
      future_player_position_new dx, dy, others
      player.hp -= @power if intersect_rect? player
	end

	def future_player_position_new dx, dy, others
    	new_x = @x + dx
	    new_y = @y + dy 
	    @future_position[:dx].x = new_x
	    @future_position[:dx].y = @y
	    @future_position[:dy].x = @x
	    @future_position[:dy].y = new_y
	    @x = future_position[:dx].x unless intersect_future_position?(others, :dx)
      	@y = future_position[:dy].y unless intersect_future_position?(others, :dy)
  	end

  	def intersect_future_position?(others, difference)
		others.find { |o| (o.object_id != self.object_id) && (o.intersect_rect? @future_position[difference]) }
	end

	def attacked_by projectile
		@hp -= projectile.power
	end

	def dead?
		@hp < 0
	end
end