class Player
	def initialize
		@x              ||= 640
	    @y              ||= 360
	    @w              ||= 16
	    @h              ||= 16
	    @attacked_at    ||= -1
	    @angle          ||= 0
	    @future_player  ||= future_player_position 0, 0
	    @projectiles    ||= []
	    @damage         ||= 0
	end

	def future_player_position  dx, dy
    	future_entity_position dx, dy, player
  	end

  	def future_entity_position dx, dy, entity
	    {
	      dx:   entity.merge(x: entity.x + dx),
	      dy:   entity.merge(y: entity.y + dy),
	      both: entity.merge(x: entity.x + dx, y: entity.y + dy)
	    }
	end
end