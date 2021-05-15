class Level

	def initialize 
	end

	def create_level level_template
	    {
	      walls:           level_template.walls.map { |w| to_cell(w.ordinal_x, w.ordinal_y).merge(w) },
	      enemies:         [],
	      spawn_locations: level_template.spawn_locations.map { |s| to_cell(s.ordinal_x, s.ordinal_y).merge(s) }
	    }
  	end
end