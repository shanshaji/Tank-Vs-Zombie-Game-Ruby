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
	      walls:           level_template.walls.map { |w| to_cell(w.ordinal_x, w.ordinal_y).merge(w) },
	      enemies:         [],
	      spawn_locations: level_template.spawn_locations.map { |s| to_cell(s.ordinal_x, s.ordinal_y).merge(s) }
	    }
	  end
	end
end