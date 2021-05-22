class Wall
	attr_sprite
	attr_rect
	attr_accessor :damage
	def initialize(x:, y:, w: 16, h: 16, destroyable: true)
		@x = x
		@y = y
		@w = w
		@h = h
		if destroyable
			random_tree = (0..3).to_a.sample
			@path = "sprites/trees/tree#{random_tree}.png"
		else
			@path = 'sprites/trees/moss_obstacle.png'
		end
		@hp = 10
		@destroyable = destroyable
	end

	def attacked_by projectile
		if @destroyable
			@hp -= projectile.power
		end
	end

	def destroyed?
		@hp < 0
	end
end