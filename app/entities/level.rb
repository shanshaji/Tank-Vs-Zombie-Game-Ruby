class Level
	extend CommonHelperMethods
	extend Levels
	@@level = 1
	@@walls = []
	@@enemies = []
	@@spawn_locations = []
  @@current_level_cumulative_power = 1
  class << self
  	def + num
  		@@level += num 
  	end

  	def level
  		@@level
  	end

  	def walls
  		@@walls
  	end

  	def enemies
  		@@enemies
  	end

  	def spawn_locations
  		@@spawn_locations
  	end

    def current_level_cumulative_power
      @@current_level_cumulative_power
    end

    def current_level_cumulative_power=(power)
      @@current_level_cumulative_power = power
    end

  	def activate_spawn_locations
  		@@spawn_locations.each(&:start_countdown)
    	@@spawn_locations
	         .find_all { |s| s.countdown.neg? }
	         .each do |s|
	      s.countdown = s.rate
	      new_enemy = Enemy.new(x: s.x, y: s.y, hp: s.enemy_hp, power: s.enemy_power, speed: s.enemy_speed)
	      unless new_enemy.intersect_multiple_rect?(@@enemies)
	        @@enemies << new_enemy
	      end
	    end
  	end

  	def activate_enemies_on player
  		others = @@enemies + @@walls
  		@@enemies.each do |enemy|
	      enemy.animate player, others
	    end
  	end

    def animate_walls
      @@walls.each do |wall|
        wall.animate
      end
    end

  	def delete_spawns_walls_enemies_if_hit
  		@@enemies.delete_if { |enemy|  enemy.dead? }
    	@@spawn_locations.delete_if{ |spawn_location| spawn_location.destroyed? }
    	@@walls.delete_if{ |wall| wall.destroyed? }
  	end

  	def create_level(w:, h:)
  		level_template = send("level_#{@@level}_template", w, h)
	end

	def completed?
		@@enemies.empty? && @@spawn_locations.empty?
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
