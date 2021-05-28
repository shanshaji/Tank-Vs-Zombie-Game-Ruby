class SpecialPower < AnimatedSprite
	attr_sprite
	attr_accessor :rect, :active

	SPECIAL_POWERS = {
	 	"Damage_Bonus": :damage_bonus,
	  	"Enemy_Speed_Debuff": :speed_increase,
	    "HP_Bonus": :health,
	    "Rockets_Bonus": :rocket
	}

	def initialize(x:, y:)
		w = 40
		h = 40
		file_name = SPECIAL_POWERS.keys.sample
		path = "sprites/special_powers/#{file_name}.png"
		super(x: x, y: y, w: w, h: h, no_of_sprites: 0, path: path)
		@type = SPECIAL_POWERS[file_name]
		@rect = [x, y, w, h]
		@active = true
	end


	def activate(player, target)
		@active = false
		case @type
		when :health
			player.hp += 100
		when :speed_increase
			player.speed += 1 unless player.speed == 4
		when :damage_bonus
			player.load_special_bullet = $game.args.state.tick_count
		when :rocket
			player.load_rocket = $game.args.state.tick_count
		end
	end
end