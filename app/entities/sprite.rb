class Sprite

	def initialize(x:, y:, w:, h:, flip_horizontally: false, flip_vertically: false)
		@x = x
		@y = y
		@w = w
		@h = h
		@flip_horizontally = false
        @flip_vertically = false
        @future_object = FutureObject.new(x, y, w, h, object_id)
	end

	def move_towards target, others
	    #determine path
	    dx =  0
	    dx =  1 if @x < target.x
	    dx = -1 if @x > target.x
	    dy =  0
	    dy =  1 if @y < target.y
	    dy = -1 if @y > target.y
	    determine_future_position dx, dy, others
	end

	def intersect_multiple_rect?(others)
		@future_object.intersect_multiple_rect? others
	end

	private

    def determine_future_position dx, dy, others
      new_x = @x + dx
      new_y = @y + dy 

      @future_object.x = new_x
      @future_object.y = y
      @x = new_x unless @future_object.intersect_multiple_rect? others

      @future_object.x = @x
      @future_object.y = new_y
      @y = new_y unless @future_object.intersect_multiple_rect? others
    end

end