class SpawnLocation
	attr_sprite
	attr_rect
	attr_accessor :rate, :countdown, :enemy_hp, :enemy_power
	def initialize(x:, y:, hp:, rate:, countdown:, enemy_power: 0.5, enemy_hp: 2)
		@x = x
		@y = y
		@w = 80
		@h = 80
		@hp = hp
		@rate = rate
		@countdown = countdown
		@enemy_hp = enemy_hp
		@enemy_power = enemy_power
		@path = 'sprites/cave/door2.png'
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