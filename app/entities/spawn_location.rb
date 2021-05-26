class SpawnLocation < AnimatedSprite
	attr_sprite
	attr_accessor :rate, :countdown, :enemy_hp, :enemy_power, :cumulative_power, :enemy_speed


	MAX_RATE = 300
	MIN_RATE = 100
	MIN_COUNTDOWN = 0
	MAX_COUNTDOWN = 5
	MIN_HEALTH = 5
	MAX_HEALTH = 20

	def initialize(x:, y:, w: 120, h: 120, hp:, rate:, countdown:)
		path = 'sprites/cave/props.png'
		super(x: x, y: y, w: w, h: h, path: path, no_of_sprites: 0)
		@hp = hp
		@rate = rate
		@countdown = countdown
		@enemy_hp = (Enemy::MIN_HP..Enemy::MAX_HP).rnd
		@enemy_power = (Enemy::MIN_POWER..Enemy::MAX_POWER).rnd
		@enemy_speed = (Enemy::MIN_SPEED..Enemy::MAX_SPEED).rnd
		@cumulative_power = ( @enemy_power + @enemy_hp + @rate + @hp + @enemy_speed )
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