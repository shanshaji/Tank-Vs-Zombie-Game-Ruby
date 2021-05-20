class SpawnLocation
	attr_sprite
	attr_accessor :rate, :countdown
	def initialize(x:, y:, hp:, rate:, countdown:)
		@x = x
		@y = y
		@w = 16
		@h = 16
		@hp = hp
		@rate = rate
		@countdown = countdown
		@damage = 0
		@path = 'sprites/square/blue.png'
	end


	def start_countdown
		@countdown -= 1
	end

	def destroyed?
		@damage > @hp
	end

	def attacked_by projectile
		@damage += 1
	end
end