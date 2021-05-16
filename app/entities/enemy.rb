class Enemy
	attr_sprite
	attr_accessor :damage, :hp, :future_position
	def initialize(x:, y:, hp: 2, w:16, h:16)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = 'sprites/square/red.png'
		@hp = hp
		@damage = 0
		# @future_object = FutureObject.new(x, y, w, h, object_id)
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
	    # create_future_player(new_x, new_y)
	    # @future_object.x = new_x
	    # @future_object.y = new_y
	    # {x: new_x, y: new_y}
	    @future_position[:dx].x = new_x
	    @future_position[:dx].y = @y
	    @future_position[:dy].x = @x
	    @future_position[:dy].y = new_y
	    # @future_position = {
	    #   dx:   {x: new_x, y: @y, w: @w, h: @h, parent_id: object_id},
	    #   dy:   {y: new_y, x: @x, w: @w, h: @h, parent_id: object_id}
	    # }
  	end

  	def intersect_future_position?(others, difference)
		others.find { |o| (o.object_id != self.object_id) && (o.intersect_rect? @future_position[difference]) }
	end

	# # def y_intersect_multiple_rect?(others)
	# # 	others.find { |o| (o != self) && (o.intersect_rect? self) }
	# # end

 #  	private


 #  	def create_future_player(x, y)
 #  		FutureObject.new(x, y, @w, @h, object_id)
 #  	end
end