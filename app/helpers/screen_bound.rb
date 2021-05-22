def screen_bound(sprite)
	if sprite.y <= 0
		sprite.y = SCREEN_BOUND_Y
	elsif  sprite.y >= SCREEN_BOUND_Y
		sprite.y = 1
	elsif  sprite.x <= 0
		sprite.x = SCREEN_BOUND_X
	elsif  sprite.x >= SCREEN_BOUND_X
		sprite.x = 1
	end
end