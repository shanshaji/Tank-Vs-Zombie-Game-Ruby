class LevelGenerator  
  class << self
	  def level_one_template
	    {
	      walls:           [{ ordinal_x: 25, ordinal_y: 20},
	                        { ordinal_x: 25, ordinal_y: 21},
	                        { ordinal_x: 25, ordinal_y: 22},
	                        { ordinal_x: 25, ordinal_y: 23}],
	      spawn_locations: [{ ordinal_x: 10, ordinal_y: 10, rate: 120, countdown: 0, hp: 5 }]
	    }
	  end
	end
end