class Wall
	attr_sprite
	include CommonHelperMethods
	attr_accessor :damage
	def initialize(ordinal_x:, ordinal_y:)
		@x = wall_to_cell(ordinal_x)
		@y = wall_to_cell(ordinal_y)
		@w = 16
		@h = 16
		@path = 'sprites/square/gray.png'
		@damage = 0
	end
end