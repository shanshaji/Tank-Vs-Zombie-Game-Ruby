module Levels
  include CommonHelperMethods
 private

  def generate_walls level, w, h
    walls = []
    number_of_walls = (Wall::MIN..Wall::MAX).rnd
    number_of_walls.each do |num|
      rand_x = (MIN_DISTANCE_FROM_BORDER..MAX_DISTANCE_FROM_BORDER).rnd
      rand_y = (MIN_DISTANCE_FROM_BORDER..MAX_DISTANCE_FROM_BORDER).rnd
      boundsX = w - rand_x
      boundsY = h - rand_y
      x = (0..boundsX).to_a.sample
      y = (0..boundsY).to_a.sample
      new_wall = Wall.new(x: x, y: y, w: 50, h: 50)

      if !intersecting? walls, new_wall
        walls << new_wall 
      end
    end
    walls
  end

  def generate_spawn_locations level, w, h, walls
    spawn_locations = []
    spawn_cumulative_power = 0
    min_cumulative_power = level * 50
    rects = walls.flatten

    until spawn_cumulative_power >= min_cumulative_power && spawn_cumulative_power > current_level_cumulative_power
      new_spawn_location = SpawnLocation.new(x: rand(w), y: rand(h), rate: (SpawnLocation::MIN_RATE..SpawnLocation::MAX_RATE).rnd, countdown: (SpawnLocation::MIN_COUNTDOWN..SpawnLocation::MAX_COUNTDOWN).rnd, hp: (SpawnLocation::MIN_HEALTH..SpawnLocation::MAX_HEALTH).rnd)
      unless intersecting? rects, new_spawn_location
        spawn_cumulative_power += new_spawn_location.cumulative_power
        spawn_locations << new_spawn_location 
        rects += [new_spawn_location]
      end
    end
    current_level_cumulative_power = spawn_cumulative_power
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

  def intersecting? rects, new_rect
    rects.find do |rect|
      rect.intersect_rect?(new_rect)
    end
  end
end

