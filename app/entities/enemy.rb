class Enemy
	attr_sprite
	attr_accessor :damage, :hp
	def initialize(x:, y:, hp: 2, w:16, h:16)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = 'sprites/square/red.png'
		@hp = hp
		@damage = 0
	end


	def attack player
		#move
	  dx =  0
      dx =  1 if @x < player.x
      dx = -1 if @x > player.x
      dy =  0
      dy =  1 if @y < player.y
      dy = -1 if @y > player.y
      @x += dx
      @y += dy 
      future_player_position_new dx, dy
	end

	def future_player_position_new dx, dy
    	new_x = @x + dx
	    new_y = @y + dy 
	    create_future_player(new_x, new_y)
  	end

  	def intersect_multiple_rect?(others)
		others.find { |o| (o != self) && (o.intersect_rect? self) }
	end

  	private


  	def create_future_player(x, y)
  		FutureObject.new(x, y, @w, @h)
  	end
end