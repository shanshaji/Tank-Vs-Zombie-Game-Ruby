class SpawnLocation < AnimatedSprite
	attr_sprite
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