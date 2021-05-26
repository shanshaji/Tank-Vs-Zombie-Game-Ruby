class Sprite
	attr_reader :future_object
	def initialize(x:, y:, w:, h:, path:, flip_horizontally: false, flip_vertically: false, angle: 0)
		@x = x
		@y = y
		@w = w
		@h = h
		@path = path
		@angle = angle
		@flip_horizontally = false
        @flip_vertically = false
        @future_object = FutureObject.new(x, y, w, h, object_id)
	end

	def intersect_multiple_rect?(others)
		@future_object.intersect_multiple_rect? others
	end


end