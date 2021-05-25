class SpawnLocation < AnimatedSprite
	attr_sprite

	class << self
		def start spawn_locations
			spawn_locations.each(&:start_countdown)
		    spawn_locations
		         .find_all { |s| s.countdown.neg? }
		         .each do |s|
		      s.countdown = s.rate
		      new_enemy = Enemy.new(x: s.x, y: s.y, hp: s.enemy_hp, power: s.enemy_power)
		      unless new_enemy.intersect_multiple_rect?(level.enemies)
		        level.enemies << new_enemy
		      end
		    end
		end
	end
	attr_accessor :rate, :countdown, :enemy_hp, :enemy_power
	def initialize(x:, y:, w: 80, h: 80, hp:, rate:, countdown:, enemy_power: 0.5, enemy_hp: 2)
		path = 'sprites/cave/door2.png'
		super(x: x, y: y, w: w, h: h, path: path, no_of_sprites: 0)
		@hp = hp
		@rate = rate
		@countdown = countdown
		@enemy_hp = enemy_hp
		@enemy_power = enemy_power
		@cumulative_power = ( enemy_power + enemy_hp + rate + hp )
	end


	def start_countdown
		@countdown -= 1
	end

	def destroyed?
		@hp < 0
	end

	def attacked_by projectile
		@hp -= projectile.power
	end
end