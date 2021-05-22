module Levels
  include CommonHelperMethods
 private

  (1..100).each do |level|
    define_method "level_#{level}_template" do |*args|
      w, h = args
      walls = []
      spawn_locations = []
      walls << add_borders(w,h)
      walls << generate_walls(level, w, h)
      spawn_locations << generate_spawn_locations(level, w, h, walls)
      {
        walls: walls.flatten,
        spawn_locations: spawn_locations.flatten
      } 
    end
  end

  def generate_walls level, w, h
    walls = []
    rand_x = (MIN_ROOM_SIZE..MAX_ROOM_SIZE).to_a.sample
    rand_y = (MIN_ROOM_SIZE..MAX_ROOM_SIZE).to_a.sample
    (1..(level * 10)).each do |num|
      boundsX = w - rand_x
      boundsY = h - rand_y
      x = (0..boundsX).to_a.sample
      y = (0..boundsY).to_a.sample
      new_wall = Wall.new(x: x, y: y, w: 50, h: 50)

      if !is_intersecting? walls, new_wall
        walls << new_wall 
      end
    end
    walls
  end

  def generate_spawn_locations level, w, h, walls
    spawn_locations = []
    (1..level).each do |num|
      new_spawn_location = SpawnLocation.new(x: rand(w), y: rand(h), rate: 220, countdown: 0, hp: 5)
      rects = spawn_locations + walls.flatten
      spawn_locations << new_spawn_location unless is_intersecting? rects, new_spawn_location
    end
    spawn_locations
  end

  def add_borders width, height
    [ 
      Wall.new(x: 0, y: 0, w: width, h: 16, destroyable: false),  
      Wall.new(x: 0, y: 0, w: 16, h: height, destroyable: false),
      Wall.new(x: 0, y: (height - 16), w: width, h: 16, destroyable: false),
      Wall.new(x: (width - 16), y: 0, w: 16, h: height, destroyable: false)
    ]
  end

  def is_intersecting? rects, new_rect
    rects.find do |rect|
      rect.intersect_rect?(new_rect)
    end
  end
end

