class FutureObject
	attr_sprite
	# include CommonHelperMethods
	def initialize(x, y, w, h)
		@x = x
		@y = y
		@w = w
		@h = h
	end

	def intersect_multiple_rect?(others)
		others.find { |o| ( o != self) && (o.intersect_rect? self) }
	end
end