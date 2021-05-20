class Wall
	attr_sprite
	attr_accessor :damage
	def initialize(x:, y:, w: 16, h: 16)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = 'sprites/square/gray.png'
		@damage = 0
	end

	def attacked_by projectile
		# @damage += 1
	end
end