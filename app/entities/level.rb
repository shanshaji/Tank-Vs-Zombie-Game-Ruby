class Level
	extend CommonHelperMethods
	extend Levels
	@@level = 1 
  class << self

  	def + num
  		@@level += num 
  	end

  	def level
  		@@level
  	end

  	def create_level(w:, h:)
  		level_template = send("level_#{@@level}_template", w, h)
	    {
	      walls:           level_template.walls,
	      enemies:         [],
	      spawn_locations: level_template.spawn_locations,
	      width: w,
	      height: h
	    }
	  end
	end

	def method_missing(m, *args)
	    method = m.to_s
	    if method.start_with?("level_")             
	        "You have beat the game"
	    else
	      super                                        
	    end
	end
end
