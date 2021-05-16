class Level
	extend CommonHelperMethods
	extend Levels
	@@level = 1 
  class << self

  	def + num
  		@@level += num 
  	end

  	def create_level
  		level_template = send("level_#{@@level}_template".to_sym)
	    {
	      walls:           level_template.walls,
	      enemies:         [],
	      spawn_locations: level_template.spawn_locations
	    }
	  end
	end
end
