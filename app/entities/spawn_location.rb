class SpawnLocation
	attr_sprite
	include CommonHelperMethods
	attr_accessor :rate, :countdown, :hp, :damage
	def initialize(ordinal_x:, ordinal_y:, hp:, rate:, countdown:)
		@x = wall_to_cell(ordinal_x)
		@y = wall_to_cell(ordinal_y)
		@w = 16
		@h = 16
		@hp = hp
		@rate = rate
		@countdown = countdown
		@damage = 0
		@path = 'sprites/square/blue.png'
	end
end