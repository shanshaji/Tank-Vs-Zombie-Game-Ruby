class Wall < AnimatedSprite
	attr_sprite
	attr_accessor :damage

	MIN ||= 40 
	MAX ||= 120
	MIN_FRAMES_SHOW ||= 10
	MAX_FRAMES_SHOW ||= 120

	def initialize(x:, y:, w: 16, h: 16, destroyable: true)
		if destroyable
			random_tree = (1..7).to_a.sample
			path = "sprites/trees/tree/tree#{random_tree}_00.png"
			w = 100
			h = 100
		else
			path = 'sprites/trees/moss_obstacle.png'
		end
		no_of_sprites = (MIN_FRAMES_SHOW..MAX_FRAMES_SHOW).rnd
		super(x: x, y: y, w: w, h: h, no_of_sprites: 3, number_of_frames_to_show_each_sprite: no_of_sprites, path: path)
		@hp = 10
		@destroyable = destroyable
	end


	def animate
		running(2) if @destroyable
	end

	def attacked_by projectile
		if @destroyable
			@hp -= projectile.power
		end
	end

	def destroyed?
		@hp < 0
	end

	def intersect_rect? target
		if @destroyable
			super(target, 20)
		else
			super(target)
		end
	end
end