class FutureObject
	attr_sprite
	def initialize(x, y, w, h)
		@x = x
		@y = y
		@w = w
		@h = h
	end

	def intersect_multiple_rect?(others)
		others.find { |o| o.intersect_rect? self }
	end
end