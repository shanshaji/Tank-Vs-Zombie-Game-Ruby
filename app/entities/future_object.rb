class FutureObject
	attr_sprite
	# include CommonHelperMethods
	attr_reader :parent_id
	def initialize(x, y, w, h, parent_id = nil)
		@x = x
		@y = y
		@w = w
		@h = h
		@parent_id = parent_id
	end

	def intersect_multiple_rect?(others)
		others.find { |o| ( o.object_id != self.parent_id) && (o.intersect_rect? self) }
	end
end