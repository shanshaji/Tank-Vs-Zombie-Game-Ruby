class Enemy < AnimatedSprite
	attr_sprite
	def initialize(x:, y:, hp: 2, w: 45, h: 45, power: 0.5, path: 'sprites/enemy/ogre/Running/0_Ogre_Running_000.png')
		super(x: x, y: y, w: w, h: h, no_of_sprites: 6, path: path)
		@hp = hp
		@power = power
	end


	def animate player, others
	  look_at player
	  move_towards player, others
		#move

      @path = running
      player.hp -= @power if intersect_rect? player
	end


	def attacked_by projectile
		@hp -= projectile.power
	end

	def dead?
		@hp < 0
	end
end